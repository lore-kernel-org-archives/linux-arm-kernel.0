From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 19 Oct 2010 22:42:53 +0200
Subject: [patch 0/9] efikamx support improvements
Message-ID: <20101019204253.162641893@rtp-net.org>
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


Regards,
Arnaud
