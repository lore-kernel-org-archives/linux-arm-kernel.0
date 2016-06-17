From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 17 Jun 2016 12:31:22 +0200
Subject: [PATCH 0/2] ARM: qcom: Add support for the MDM9615
Message-ID: <1466159484-21858-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support the Qualcomm MDM9615 in the Sierra Wireless WP8548
Modules, add the MDM9615 compatible entry, configs and bindings.

This patchset depends on pinctrl [1], clk [2] and pmic [3] patchsets.

This patchset is part of a global SoC + Module + Board support for the
Sierra Wireless mangOH Board support with the WP8548 module.

[1] http://lkml.kernel.org/r/1466158535-17962-1-git-send-email-narmstrong at baylibre.com
[2] http://lkml.kernel.org/r/1466157875-14428-1-git-send-email-narmstrong at baylibre.com
[3] http://lkml.kernel.org/r/1466158929-19524-1-git-send-email-narmstrong at baylibre.com

Neil Armstrong (2):
  ARM: qcom: Add support for MDM9615
  ARM: configs: qualcomm: Add MDM9615 missing defconfigs

 arch/arm/configs/qcom_defconfig | 14 ++++++++++++++
 arch/arm/mach-qcom/Kconfig      |  4 ++++
 arch/arm/mach-qcom/board.c      |  1 +
 3 files changed, 19 insertions(+)

-- 
1.9.1
