From: jon.mason@broadcom.com (Jon Mason)
Date: Mon,  5 Dec 2016 18:12:20 -0500
Subject: [PATCH 0/2] arm64: dts: NS2: XMC support and Nitro memreserve
Message-ID: <1480979542-26871-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the NS2 XMC formfactor via a new DTS file.  Also, set
aside memory for Nitro firmware in the NS2 DTSI file.

Jon Mason (2):
  arm64: dts: NS2: reserve memory for Nitro firmware
  arm64: dts: NS2: add support for XMC form factor

 arch/arm64/boot/dts/broadcom/Makefile    |   2 +-
 arch/arm64/boot/dts/broadcom/ns2-xmc.dts | 191 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi    |   2 +
 3 files changed, 194 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/ns2-xmc.dts

-- 
2.7.4
