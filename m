From: jon.mason@broadcom.com (Jon Mason)
Date: Mon, 28 Nov 2016 14:31:29 -0500
Subject: [PATCH 0/2] arm64: dts: NS2: Add GICv2m and PAXC
Message-ID: <1480361491-22221-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for GICv2m and PAXC.  GICv2m was tested on an e1000e
adapter, with some hacking of the driver to verify MSI and legacy
interrupts work.

Jon Mason (2):
  arm64: dts: NS2: enable GICv2m for PAXB/PAXC interfaces
  arm64: dts: NS2: enable PAXC on NS2 SVK

 arch/arm64/boot/dts/broadcom/ns2-svk.dts |   4 +
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 121 +++++++++++++++++++++++++------
 2 files changed, 101 insertions(+), 24 deletions(-)

-- 
2.7.4
