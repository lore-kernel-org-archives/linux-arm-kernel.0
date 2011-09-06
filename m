From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 06 Sep 2011 19:25:15 +0530
Subject: [PATCH 0/2] Add device tree support for Samsung's keypad controller
	driver
Message-ID: <1315317317-21873-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds device tree support for samsung's keypad controller driver.
First patch adds a new config option to be used by device tree enabled platforms
for selecting the samsung's keypad controller driver. The second patch adds device
tree support for the keypad driver.

Thomas Abraham (2):
  input: samsung-keypad: Add HAVE_SAMSUNG_KEYPAD config option
  input: samsung-keypad: Add device tree support

 .../devicetree/bindings/input/samsung-keypad.txt   |   88 +++++++++++
 drivers/input/keyboard/Kconfig                     |    9 +-
 drivers/input/keyboard/samsung-keypad.c            |  161 +++++++++++++++++++-
 3 files changed, 254 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/samsung-keypad.txt
