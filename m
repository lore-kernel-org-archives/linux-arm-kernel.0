From: sricharan@codeaurora.org (Sricharan R)
Date: Tue, 20 Mar 2018 09:28:43 +0530
Subject: [PATCH v3 00/13] ARM: dts: ipq: updates to enable a few peripherals
Message-ID: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[v3]
    * Fixed minor comments from v2,
      https://www.spinics.net/lists/arm-kernel/msg641480.html

    * Added Abhishek's review tags

[v2]
    * Addressed all comments from Abhishek
    * Removed dk01-c2 and dk04-c5 spinand based boards
      as support for spinand is not complete
    * Based all patches on top of Andy's for-next branch

[V1]
    * https://www.spinics.net/lists/arm-kernel/msg631318.html

Sricharan R (13):
  firmware: qcom: scm: Add ipq4019 soc compatible
  ARM: dts: ipq4019: Add a few peripheral nodes
  ARM: dts: ipq4019: Change the max opp frequency
  ARM: dts: ipq4019: Update ipq4019-dk01.1 board data
  ARM: dts: ipq4019: Add ipq4019-ap.dk04.dtsi
  ARM: dts: ipq4019: Add ipq4019-ap.dk04.1-c1 board file
  ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk04.1-c3 board file
  ARM: dts: ipq4019: Add ipq4019-ap.dk07.1 common data
  ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c1 board file
  ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c2 board file
  ARM: dts: ipq8074: Add peripheral nodes
  ARM: dts: ipq8074: Add pcie nodes
  ARM: dts: ipq8074: Enable few peripherals for hk01 board

 .../devicetree/bindings/firmware/qcom,scm.txt      |   3 +-
 arch/arm/boot/dts/Makefile                         |   4 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi      |  32 ++-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts    |  20 ++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts    |   8 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi      | 135 +++++++++++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts    |  65 +++++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts    |  26 ++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi      |  83 +++++++
 arch/arm/boot/dts/qcom-ipq4019.dtsi                | 136 ++++++++++-
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts          | 103 ++++++++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              | 262 ++++++++++++++++++++-
 drivers/firmware/qcom_scm.c                        |   3 +
 13 files changed, 875 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
