From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 26 Oct 2010 22:07:23 +0200
Subject: [patch v3 00/10] efikamx support improvements - take 3
Message-ID: <20101026200723.839428019@rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Hi,

This patchset aims at improving current efikamx support. It adds support for :
- board id detection
- sdhc
- leds
- power button
- spi nor
- reset

I also had to fix/improve some imx51 iomux header so there are patches for
iomux-mx51.h.

v3:
- use imx51_add_gpio_keys
- fix patch description for power key patch

v2:
- split iomux patch 3 into 2 patches
- reorder patches
- fix space comment
- fix Amit's comments
- decrease board id msleep

Arnaud
