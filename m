From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 30 Sep 2015 11:22:46 +0900
Subject: [GIT PULL] arm64: dts: Exynos ARMv8 improvements for 4.4
In-Reply-To: <1443579766-15793-1-git-send-email-k.kozlowski@samsung.com>
References: <1443579766-15793-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1443579766-15793-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin,

One ARMv8 DTS change for 4.4.

Best regards,
Krzysztof

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  https://github.com/krzk/linux.git tags/samsung-dt64-4.4

for you to fetch changes up to 235c8e96f54a76bee201a7c86620c351a30b1ac6:

  arm64: dts: Add BUS1 instance pinctrl support for exynos7 (2015-09-16 09:03:09 +0900)

----------------------------------------------------------------
Device Tree improvements for Exynos ARMv8 based boards:
1. Add a BUS1 instance pinctrl for Exynos7 SoC.

----------------------------------------------------------------
Alim Akhtar (1):
      arm64: dts: Add BUS1 instance pinctrl support for exynos7

 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi | 103 ++++++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos7.dtsi         |   7 ++
 2 files changed, 110 insertions(+)
