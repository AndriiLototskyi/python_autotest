from selenium import webdriver
import time
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains


credentials_login=""
credentials_password = ""

provider_name = 'Budget'
lor = '28'

driver = webdriver.Chrome()
driver.maximize_window()
driver.get("https://ci-dev.fornova.com/")
time.sleep(5)


# login
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
# login


# locationAV
toLocationAV = driver.find_element(
    By.XPATH,
    "//span[contains(@class, 'icon-Unavailable-Locations')]"
).click()
time.sleep(5)

clickLOKList = driver.find_element(
    By.XPATH,
    "//label[contains(text(),'LOK')]/../div[@class='el-select select el-select--mini']"
).click()

clickLOK = driver.find_element(
    By.XPATH,
    "//span[text()='"+lor+"']"
)
actions = ActionChains(driver)
actions.move_to_element(clickLOK).perform()
clickLOK.click()
time.sleep(2)

NAdaysLocationAV=driver.find_element(
        By.XPATH,
    "//p[contains(text(), 'London Heathrow Airport')]/../..//div[@title='"+provider_name+"']/../div[@class='location-data__closed-days']")
numberofNAdaysUI = int(NAdaysLocationAV.text)
time.sleep(2)


# API
import requests
import json


response_API = requests.get('https://ci-backend-dev-ci-ingress.pres-nonprod.gcphosts.net/car/get-not-available-docs/2023/8/GB/12')
data = response_API.text
parse_jsonList =json.loads(data)
parse_jsonDict = parse_jsonList[0]
LAdata = parse_jsonDict['pickup_dates']


providerLorNADays = list()
for item in LAdata:
    if provider_name in LAdata[item].keys():
        dateData = LAdata[item]
        providerData = dateData[provider_name]
        if lor in providerData.keys():
            providerLorNADays.append(providerData[lor])



numberofNAdaysAPI = 0
for x in providerLorNADays:
    if x:
        numberofNAdaysAPI+=1
# API


print('numberofNAdaysAPI: ' + str(numberofNAdaysAPI))
print('numberofNAdaysUI: ' + str(numberofNAdaysUI))
print('Match? : '+str(numberofNAdaysUI == numberofNAdaysAPI))


