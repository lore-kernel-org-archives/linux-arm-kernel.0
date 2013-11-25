From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Nov 2013 10:00:13 +0900
Subject: [PATCH 0/3] ARM: shmobile: marzen: enable HSPI0 to DTS
Message-ID: <1385341216-27101-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series enables HSPI0 in DTS for the r8a7779 based marzen board.
It is based on work by Kuninori Morimoto for the r8a7778 based bockw board.

This series is based on the renesas-devel-v3.13-rc1-20131124 tag
of my renesas tree.


Simon Horman (3):
  ARM: shmobile: r8a7779: add HSPI clock support for DT
  ARM: shmobile: r8a7779: add HSPI support to DTSI
  ARM: shmobile: marzen: enable HSPI0 in DTS

 arch/arm/boot/dts/r8a7779-marzen-reference.dts | 11 ++++++++++
 arch/arm/boot/dts/r8a7779.dtsi                 | 30 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7779.c         |  3 +++
 3 files changed, 44 insertions(+)

-- 
1.8.4
