From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 19 Jul 2011 00:45:06 +0800
Subject: [PATCH 0/2] add device tree probe support for gpio_keys
Message-ID: <1311007508-8096-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch gets the driver stop referencing platform_data after
.probe exits.  And the second patch adds the actual device tree probe
support for the driver.

Shawn Guo (2):
      Input: gpio-keys: do not reference platform_data after .probe exits
      Input: gpio-keys: add device tree probe support

 Documentation/devicetree/bindings/gpio/key.txt |   57 +++++++++++
 drivers/input/keyboard/gpio_keys.c             |  128 +++++++++++++++++++-----
 2 files changed, 161 insertions(+), 24 deletions(-)
