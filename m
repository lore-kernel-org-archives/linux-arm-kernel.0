From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 18 May 2015 10:47:12 +0900
Subject: [PATCH v2 0/4] ARM: multi_v7_defconfig: Stuff for Exynos
Message-ID: <1431913636-31854-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin,


Changes since v1:
=================
1. Select drivers as modules, whenever possible. Suggested by Javier.
2. Patch 2: The I2C_GPIO is already enabled as module.


Description
===========
The patchset enables various config options on multi_v7 config
for Exynos boards.

Arnd suggested [0] that this can go through your tree.

Patchset is rebased on next-20150515 and Javier's patchset [1]
(to avoid conflicts around regulators and clocks).

Please let me know if this should be rebased on other commit.

[0] http://www.spinics.net/lists/kernel/msg1991518.html
[1] http://www.spinics.net/lists/kernel/msg1990767.html


Best regards,
Krzysztof

Krzysztof Kozlowski (4):
  ARM: multi_v7_defconfig: Enable CPU idle for Exynos
  ARM: multi_v7_defconfig: Enable PMIC and MUIC drivers for Exynos
    boards
  ARM: multi_v7_defconfig: Enable TMU for Exynos
  ARM: multi_v7_defconfig: Enable OHCI on Exynos

 arch/arm/configs/multi_v7_defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
1.9.1
