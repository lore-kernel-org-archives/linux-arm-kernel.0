From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Jan 2018 10:36:32 +0100
Subject: [PATCH 0/3] ARM: dts: renesas: consistently use single space before =
Message-ID: <20180126093635.16945-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consistently use a single space before a =.

This series fixes instances where a tab is used instead.

This is part of an ongoing effort to improve consistency within and between
the DT of Renesas SoCs to allow for easier comparison and maintenance.

This series should not introduce any functional change.

Based on renesas-devel-20180123-v4.15-rc9

Simon Horman (3):
  ARM: dts: r8a7790: consistently use single space before =
  ARM: dts: r8a7791: consistently use single space before =
  ARM: dts: r8a7793: consistently use single space before =

 arch/arm/boot/dts/r8a7790.dtsi | 10 +++++-----
 arch/arm/boot/dts/r8a7791.dtsi | 10 +++++-----
 arch/arm/boot/dts/r8a7793.dtsi | 10 +++++-----
 3 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.11.0
