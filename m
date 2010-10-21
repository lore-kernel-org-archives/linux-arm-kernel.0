From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 21 Oct 2010 12:38:55 +0200
Subject: [patch v2 00/10] efikamx support improvements - try 2
Message-ID: <20101021103855.115653951@rtp-net.org>
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

v2:
- split iomux patch 3 into 2 patches
- reorder patches
- fix space comment
- fix Amit's comments
- decrease board id msleep

Arnaud
