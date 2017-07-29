From: abhishek.shah@broadcom.com (Abhishek Shah)
Date: Sat, 29 Jul 2017 10:12:22 +0530
Subject: [PATCH 0/7] Add more DT nodes for Stingray SoC
Message-ID: <1501303349-30007-1-git-send-email-abhishek.shah@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is round two of adding DT nodes for Stingray SoC.
Corresponding drivers and dt binding documents are already
checked in the kernel and will be present in v4.14.

Abhishek Shah (1):
  arm64: dts: Add DT node to enable BGMAC driver on Stingray

Anup Patel (3):
  arm64: dts: Add sp804 DT nodes for Stingray SoC
  arm64: dts: Add FlexRM DT nodes for Stingray
  arm64: dts: Add SBA-RAID DT nodes for Stingray SoC

Srinath Mannam (2):
  arm64: dts: Add MDIO multiplexer DT node for Stingray
  arm64: dts: Add SATA DT nodes for Stingray SoC

Velibor Markovski (1):
  arm64: dts: Enable stats for CCN-502 interconnect on Stingray

 .../boot/dts/broadcom/stingray/bcm958742-base.dtsi |  78 ++++++
 .../boot/dts/broadcom/stingray/bcm958742k.dts      |   4 +
 .../boot/dts/broadcom/stingray/bcm958742t.dts      |   4 +
 .../boot/dts/broadcom/stingray/stingray-fs4.dtsi   | 118 +++++++++
 .../boot/dts/broadcom/stingray/stingray-sata.dtsi  | 278 +++++++++++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 136 ++++++++++
 6 files changed, 618 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-fs4.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi

-- 
2.7.4
