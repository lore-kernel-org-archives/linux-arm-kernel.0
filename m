From: yendapally.reddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Tue, 29 Mar 2016 11:22:10 -0400
Subject: [PATCH RESEND 0/2] pinmux support for Broadcom NS2 SoC
Message-ID: <1459264932-27884-1-git-send-email-yendapally.reddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the pinmux support for the Broadcom's
Northstar 2 (NS2) SoC.

The first patch provides the driver details and the second patch contains
the enable method. The documentation details patch is already merged.

This patch set has been tested on NS2 bcm958712K board.
This patch set is based on v4.6.0-rc1 and is available from github
repo: https://github.com/Broadcom/arm64-linux.git
branch: ns2-pinmux-v1

Yendapally Reddy Dhananjaya Reddy (2):
  pinctrl: ns2: add pinmux driver support for Broadcom NS2 SoC
  ARM: dts: enable pinctrl for Broadcom NS2 SoC

 arch/arm64/boot/dts/broadcom/ns2-svk.dts |    9 +
 arch/arm64/boot/dts/broadcom/ns2.dtsi    |    7 +
 drivers/pinctrl/bcm/Kconfig              |   13 +
 drivers/pinctrl/bcm/Makefile             |    1 +
 drivers/pinctrl/bcm/pinctrl-ns2-mux.c    | 1122 ++++++++++++++++++++++++++++++
 5 files changed, 1152 insertions(+)
 create mode 100644 drivers/pinctrl/bcm/pinctrl-ns2-mux.c

-- 
2.1.0
