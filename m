From: contact@paulk.fr (Paul Kocialkowski)
Date: Tue, 29 Mar 2016 21:28:21 +0200
Subject: [PATCH 0/5] Amazon Kindle Fire (first generation) codename kc1
 support series
Message-ID: <1459279707-17611-1-git-send-email-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds basic support for the Amazon Kindle Fire (first generation)
codename kc1. A few features such as serial, i2c, the internal eMMC, USB gadget
and power button leds.

It requires some TWL-related patches to work properly, in particular:
* pwm: twl: Reliably disable TWL6030 PWMs
* mfd: Add TWL6030 power driver, with minimal support for power off
