From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 20 Jan 2016 13:29:50 +0100
Subject: PATCH [0/2] ARM: dts: am33xx: add support for Ka-Ro electronics
 TX48-7020 module
Message-ID: <1453292992-1788-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for the Ka-Ro electronics TX48-7020
module.

The first patch adds a workaround for a bug in the AM335x SoC to the
LTC3589 driver, which is required for this module.

regulator: ltc3589: make IRQ optional
ARM: dts: am33xx: add support for Ka-Ro electronics TX48-7020 module
