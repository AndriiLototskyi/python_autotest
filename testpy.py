from selenium import webdriver
import time
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
import pytest

global credentials_login,credentials_password
credentials_login="and.lototskyi@gmail.com"
credentials_password = "555555"

@pytest.fixture()
def test_setup():
    global driver
    driver = webdriver.Chrome()
    driver.maximize_window()
    yield
    driver.close()
    driver.quit()

def test_login(test_setup):
    driver.get("https://ci-dev.fornova.com/")
    time.sleep(5)
    login = driver.find_element(
        By.XPATH,
        "//input[@class='form-control icon icon-email ng-untouched ng-pristine ng-invalid']"
            ).send_keys(credentials_login)

    password = driver.find_element(
        By.XPATH,
        "//input[@class='form-control icon icon-pass ng-untouched ng-pristine ng-invalid']"
    ).send_keys(credentials_password)

    loginButton = driver.find_element(By.XPATH,     "//button[@class='submit-btn']").click()
    time.sleep(10)


# def test_teardown():
#     driver.close()
#     driver.quit()