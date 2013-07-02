From: lho@apm.com (Loc Ho)
Date: Tue,  2 Jul 2013 14:38:57 -0600
Subject: [PATCH 0/2] power: Add APM X-Gene SoC system reboot driver.
Message-ID: <1372797539-13111-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add APM X-Gene SoC system reboot driver. This driver only supports system
reboot. System shutdown is board specific and will be handled by board specific
driver or GPIO based driver.

Loc Ho (2):
  power: Add APM X-Gene SoC system reboot driver. This driver handles
    only
  power: arm64: Add DTS entry for APM X-Gene reboot driver.

 arch/arm64/boot/dts/apm-storm.dtsi |    6 ++
 drivers/power/reset/Kconfig        |    7 +++
 drivers/power/reset/Makefile       |    1 +
 drivers/power/reset/xgene-reboot.c |  101 ++++++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 0 deletions(-)
 create mode 100755 drivers/power/reset/xgene-reboot.c
