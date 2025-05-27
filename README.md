# Spend Manager iOS Sample App

## Overview

The sample provides a simple, but fully functional implementation, which explores various integration options and demonstrates the features and the configurability of the Sensibill SDK.

Currently the following flows are demonstrated by the sample:

* Standalone Capture Integration
  * Capture invocation
  * Processig the results of the Standalone Capture

* Full SDK integration:
  * Start / stop SDK
  * Start Sensibill UI (Web UI) with default and custom options
  * Capture Flow: Capture invocation with receipt upload
  * Capture Flow with Edit Metadata, when upon Capture completion, and while receipts are uploaded, user can provide the receipt metadata.

## Prerequisites

* Xcode
* [Cocoapods](https://cocoapods.org/)
* Access to Sensibill API (provided by Sensibill support team)

## Installation

1. Clone the repository
2. Navigate to `SpendManagerSample` folder, and run `pod install`
3. In Xcode open `SpendManagerSample.xcworkspace`

## Configuration

The configuration of the sample is done in a `DemoConfig` file.

The only **required** configuration is the replacement of `accessToken` value from the placeholder `TOKENVALUE` to a valid user access token.

All other configuration items are optional to change, and allow to explore various integration features and flows. See explanations provided for each option for more details.
