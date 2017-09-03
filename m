From: plaes@plaes.org (Priit Laes)
Date: Sun,  3 Sep 2017 16:50:15 +0300
Subject: [PATCH 0/3] ARM: dts: sunxi: Use defines for ccu clock indices
Message-ID: <cover.28f5be8e511ad74e9ae3f573891882e62bebdb7b.1504446535.git-series.plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a follow-up commit for sun{4,7}i ccu conversion. Now that
all the relevant pieces have been merged we can use dt-binding headers
again.

Also included is additional patch to add i2s0 block to sun4i dtsi header.

Priit Laes (3):
  ARM: dts: sun4i: Use defines for clock and reset indices
  ARM: dts: sun7i: Use defines for clock and reset indices
  ARM: dts: sun4i: Add i2s0 block to dtsi

 arch/arm/boot/dts/sun4i-a10.dtsi | 134 ++++++++++++++++-------------
 arch/arm/boot/dts/sun7i-a20.dtsi | 146 ++++++++++++++++----------------
 2 files changed, 148 insertions(+), 132 deletions(-)

base-commit: d11067fd67a0549b0e7b330dbcbdc28f90ba5712
-- 
git-series 0.9.1
