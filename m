From: xuwei5@hisilicon.com (Wei.Xu)
Date: Fri, 7 Apr 2017 10:07:51 +0800
Subject: [PATCH 0/5] arm64: dts: hisi: add NIC, RoCE and SAS support for hip07
Message-ID: <1491530876-109791-1-git-send-email-xuwei5@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds Mbigen, NIC, RoCE and SAS nodes for the hip07
SoC and enables the NIC, RoCE and SAS on the hip07 d05 board.

Wei Xu (5):
  arm64: dts: hisi: add mbigen nodes for the hip07 SoC
  arm64: dts: hisi: add network related nodes for the hip07 SoC
  arm64: dts: hisi: add RoCE nodes for the hip07 SoC
  arm64: dts: hisi: add SAS nodes for the hip07 SoC
  arm64: dts: hisi: enalbe the NIC and SAS for the hip07-d05 board

 arch/arm64/boot/dts/hisilicon/hip07-d05.dts |  24 ++
 arch/arm64/boot/dts/hisilicon/hip07.dtsi    | 479 ++++++++++++++++++++++++++++
 2 files changed, 503 insertions(+)

-- 
1.9.1
