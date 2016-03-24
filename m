From: plaes@plaes.org (Priit Laes)
Date: Thu, 24 Mar 2016 21:52:15 +0200
Subject: [PATCH v2 0/2] ARM: sunxi: dt: Add missing DRAM gate clock for
 simplefb TV output
Message-ID: <1458849137-3883-1-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DRAM gating driver commit for sun[47]i seems to be missing DRAM gate bit 5 for
simplefb TV output node. Add it.

v2 changes:
 - Added Cc:stable and Fixes tags

Priit Laes (2):
  ARM: sun4i: dt: Enable dram gate 5 (tve0 clock) for simplefb TV output
  ARM: sun7i: dt: Enable dram gate 5 (tve0 clock) for simplefb TV output

 arch/arm/boot/dts/sun4i-a10.dtsi | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.5.0
