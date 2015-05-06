From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 06 May 2015 09:58:23 +0900
Subject: ARM: EXYNOS: dts: DTS fixes for 4.1
Message-ID: <1430873903-22787-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin,

This groups important fix for current RC cycle, well tested and
present on mailing list for some time.

Best regards,
Krzysztof

----------------------------------------------------------------
The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

are available in the git repository at:

  https://github.com/krzk/linux.git tags/samsung-dt-fixes-4.1

for you to fetch changes up to d52ccd7b731f881df051331c92a5c54a94adf516:

  ARM: dts: Make DP a consumer of DISP1 power domain on Exynos5420 (2015-05-05 19:15:57 +0900)

----------------------------------------------------------------
Fix for imprecise external abort on Exynos5420 boards introduced after adding
display power domain in DTS.

----------------------------------------------------------------
Javier Martinez Canillas (1):
      ARM: dts: Make DP a consumer of DISP1 power domain on Exynos5420

 arch/arm/boot/dts/exynos5420.dtsi | 1 +
 1 file changed, 1 insertion(+)
