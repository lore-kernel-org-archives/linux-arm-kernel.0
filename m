From: biju.das@bp.renesas.com (Biju Das)
Date: Fri,  7 Jul 2017 14:12:43 +0100
Subject: [PATCH v 0/2] Add R8A7743/iwg20d-q7 Ethernet AVB support
Message-ID: <1499433165-62475-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series aims to add device tree support for Ethernet AVB on R8A7743 SoC/iwg20d-q7 platform

This series has been tested against linux-next tag next-20170704.

It depends upon the patch 
https://www.mail-archive.com/netdev at vger.kernel.org/msg176852.html

Biju Das (2):
  ARM: dts: r8a7743: Add Ethernet AVB support
  ARM: dts: iwg20d-q7: Add Ethernet AVB support

 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 21 +++++++++++++++++++++
 arch/arm/boot/dts/r8a7743.dtsi          | 13 +++++++++++++
 2 files changed, 34 insertions(+)

-- 
1.9.1
