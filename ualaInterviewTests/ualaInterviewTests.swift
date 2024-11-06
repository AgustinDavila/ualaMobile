import XCTest
@testable import ualaInterview

final class ualaInterviewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class CountryViewModelTests: XCTestCase {
    var viewModel: CountryViewModel!

    override func setUp() {
        super.setUp()
        viewModel = CountryViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testSelectCountrySuccess() {
        let country = Constants.countryMock

        viewModel.selectCountry(country)

        XCTAssertEqual(viewModel.selectedCountry?.id, Constants.countryMock.id)
    }

    func testFilterSuccess() {
        viewModel.loadAllCountries(Constants.Testing.countries)
        viewModel.prompt = "Al"

        viewModel.filterCountries()

        XCTAssertEqual(viewModel.countriesList, [Constants.Testing.country6, Constants.Testing.country7])
    }

    func testFilterInsensitiveCaseSuccess() {
        viewModel.loadAllCountries(Constants.Testing.countries)
        viewModel.prompt = "s"

        viewModel.filterCountries()

        XCTAssertEqual(viewModel.countriesList, [Constants.Testing.country10])
    }

    func testFilterFail() {
        viewModel.loadAllCountries(Constants.Testing.countries)
        viewModel.prompt = "Alb"

        viewModel.filterCountries()

        XCTAssertNotEqual(viewModel.countriesList, [Constants.Testing.country6, Constants.Testing.country7])
    }

    func testFilterInvalidSuccess() {
        viewModel.loadAllCountries(Constants.Testing.countries)
        viewModel.prompt = "123456789"

        viewModel.filterCountries()

        XCTAssertEqual(viewModel.countriesList, [])
    }
}


class RemoteRepositoryTests: XCTestCase {
    let countries = Constants.Testing.countries

    func testGetCountriesSuccess() async throws {
        let client = NetworkingClientMock(result: countries)
        let repository = RemoteRepository(client: client)
        let fetchedCountries = try await repository.getCountries()

        XCTAssertNotNil(fetchedCountries)
        XCTAssertEqual(fetchedCountries?.count, 10)
    }

    func testGetCountriesFail() async throws {
        let error = NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Error"])
        let networkingClientMock = NetworkingClientMock(error: error)
        let repository = RemoteRepository(client: networkingClientMock)

        do {
            _ = try await repository.getCountries()
            XCTFail("Should fail")
        } catch let thrownError as NSError {
            XCTAssertEqual(thrownError.localizedDescription, "Error")
        }
    }
}

class RouterTests: XCTestCase {
    var router = Router()

    override func tearDown() {
        router.popToRoot()
        super.tearDown()
    }

    func testNavigateTo() throws {
        router.navigateTo(.countryMapView)
        XCTAssertEqual(router.path.count, 1)
    }

    func testNavigateBack() throws {
        router.navigateTo(.countryMapView)
        router.navigateTo(.countryMapView)

        XCTAssertEqual(router.path.count, 2)

        router.navigateBack()

        XCTAssertEqual(router.path.count, 1)
    }

    func testPopToRoot() throws {
        router.navigateTo(.countryMapView)
        router.navigateTo(.countryMapView)
        router.navigateTo(.countryMapView)

        XCTAssertEqual(router.path.count, 3)

        router.popToRoot()

        XCTAssertEqual(router.path.count, 0)
    }
}


class BookmarkTests: XCTestCase {

    let BOOKMARKS_KEY = "bookmarks"
    var userDefaults: UserDefaults?

    override func setUp() {
        super.setUp()
        userDefaults = UserDefaults.standard
    }

    override func tearDown() {
        userDefaults = nil
        super.tearDown()
    }

    func testSaveBookmarks() throws {
        let countries = Constants.Testing.countries

        try BookmarkManager.saveBookmarks(countries)

        guard let data = userDefaults?.data(forKey: BOOKMARKS_KEY) else {
            XCTFail("Fail")
            return
        }

        let bookmarkedCountries = try JSONDecoder().decode(Countries.self, from: data)

        XCTAssertEqual(bookmarkedCountries, countries)
    }

    func testLoadBookmarks() throws {
        let countries = Constants.Testing.countries

        let data = try JSONEncoder().encode(countries)
        userDefaults?.set(data, forKey: BOOKMARKS_KEY)

        guard let bookmarkedCountries = try BookmarkManager.loadBookmarks() else {
            XCTFail("Fail")
            return
        }

        XCTAssertEqual(bookmarkedCountries, countries)
    }
}

