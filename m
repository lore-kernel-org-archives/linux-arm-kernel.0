From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Fri, 15 May 2015 21:48:58 +0900
Subject: [PATCH 0/4] ARM: multi_v7_defconfig: Stuff for Exynos
Message-ID: <1431694142-32141-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin,

The patchset enables various config options on multi_v7 config
for Exynos boards. The first two patches are actually resend.

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

 arch/arm/configs/multi_v7_defconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.1.4
