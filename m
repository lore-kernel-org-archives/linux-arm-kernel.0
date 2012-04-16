From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 17 Apr 2012 00:05:05 +0200
Subject: [patch 0/1] Kirwood: Add Iomega Iconnect support
Message-ID: <20120416220505.002573737@rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following patch is adding support for Iomaga Iconnect kirkwood box. It has
tested against arm-soc#for-next of some days ago and with ARM_APPENDED_DTB as
the uboot I have on this device doesn't support device tree.
The DTS file only handles the serial port as it seems it's the only device
with OF support [ rtc-mv is converted too but it's already handled by
kirkwood.dtsi ]


Arnaud Patard
