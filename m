From: sricharan@codeaurora.org (Sricharan R)
Date: Mon, 29 Jan 2018 10:41:14 +0530
Subject: [PATCH 00/15] ARM: dts: ipq: updates to enable a few peripherals
Message-ID: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver support for ipq based platform's spi, i2c, nand,
spi-nor, pcie is available now. So update the dts to enable
those peripherals.

Sricharan R (15):
  firmware: qcom: scm: Add ipq soc compatibles
  ARM: dts: ipq4019: Add a few peripheral nodes
  ARM: dts: ipq4019: Change the max opp frequency
  ARM: dts: ipq4019: Update ipq4019-dk01.1 board data
  ARM: dts: ipq4019: Add ipq4019-ap-dk01-c2 board file
  ARM: dts: ipq4019: Add ipq4019-ap.dk04.dtsi
  ARM: dts: ipq4019: Add ipq4019-ap.dk04.1-c1 board file
  ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk04.1-c5 board file
  ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk04.1-c3 board file
  ARM: dts: ipq4019: Add ipq4019-ap.dk07.1 common data
  ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c1 board file
  ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c2 board file
  ARM: dts: ipq8074: Add peripheral nodes
  ARM: dts: ipq8074: Add pcie nodes
  ARM: dts: ipq8074: Enable few peripherals for hk01 board

 .../devicetree/bindings/firmware/qcom,scm.txt      |   3 +-
 arch/arm/boot/dts/Makefile                         |   6 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c2.dts    |  25 ++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi      |  28 +++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts    |   8 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts    |  14 ++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c5.dts    |  23 ++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi      | 147 ++++++++++++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts    |  60 +++++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts    |  78 +++++++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi      | 128 ++++++++++
 arch/arm/boot/dts/qcom-ipq4019.dtsi                | 136 ++++++++++-
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts          |  99 ++++++++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              | 258 ++++++++++++++++++++-
 drivers/firmware/qcom_scm.c                        |   3 +
 15 files changed, 1013 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c2.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c5.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
