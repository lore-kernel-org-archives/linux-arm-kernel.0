From: mike.rapoport@gmail.com (Mike Rapoport)
Date: Fri, 26 Sep 2014 11:07:29 +0300
Subject: [PATCH 0/2] qcom: add CM-QS600 board
Message-ID: <1411718851-17436-1-git-send-email-mike.rapoport@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches add DT for CompuLab CM-QS600 board which is similar to ifc6410

Mike Rapoport (2):
  ARM: DT: apq8064: create qcom-apq8064-board-common.dtsi
  ARM: DT: apq8064: add CM-QS600 board

 arch/arm/boot/dts/Makefile                       |  1 +
 arch/arm/boot/dts/qcom-apq8064-board-common.dtsi | 57 ++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts      |  7 +++
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts       | 54 +---------------------
 4 files changed, 66 insertions(+), 53 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-board-common.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts

-- 
1.9.1
