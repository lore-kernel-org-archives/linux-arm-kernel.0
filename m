From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 27 Oct 2010 14:40:45 +0200
Subject: [patch v4 00/10] efikamx support improvements - take 4
Message-ID: <20101027124044.980739780@rtp-net.org>
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

v4:
- reorder selects for the machine Kconfig entry
- drop linux/gpio_keys.h include
- mark mx51_efikamx_powerkey_data as const & __initconst
- add missing return after calling mx51_efikamx_reset()

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
