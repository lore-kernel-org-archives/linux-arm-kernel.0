From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 18 Nov 2015 14:20:33 -0800
Subject: [PATCH 0/2] ARM: shmobile: gose: Add GPIO keys and leds to DT
Message-ID: <1447885235-17858-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series adds GPIO keys and leds to the device tree
of the r8a7793 based Gose board.

It uses the makes use of the recently addition of GPIO devices
to the device tree of the r8a7793. Thanks Magnus!

I have booted a system with these changes and verified that the
relevant entries appear to be present in sysfs.

I have not tested button press events or illumination of the leds
as I do not currently have physical access to a Gose board.

Based on renesas-devel-20151118-v4.4-rc1

Simon Horman (2):
  ARM: shmobile: gose: Add GPIO keys to DT
  ARM: shmobile: gose: Add GPIO leds to DT

 arch/arm/boot/dts/r8a7793-gose.dts | 98 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

-- 
2.1.4
