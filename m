From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 11 Jul 2016 18:41:18 +0200
Subject: [GIT PULL 4/4] arm64: defconfig: Stuff for exynos for v4.8, last round
In-Reply-To: <1468255278-32162-1-git-send-email-k.kozlowski@samsung.com>
References: <1468255278-32162-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1468255278-32162-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Last round of commits for v4.8.

Best regards,
Krzysztof


The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig64-4.8

for you to fetch changes up to 426f754be0bc258c269524bce162ae0ca1cb8927:

  arm64: defconfig: Enable more IP blocks for Exynos7 and Exynos5433 (2016-07-11 08:06:54 +0200)

----------------------------------------------------------------
Samsung defconfig updates for ARM64 - enable drivers for
Exynos7 and Exynos5433 based boards:
1. S2MPS clock driver,
2. SoC: RTC, SPI, watchdog, EHCI, OHCI, DWC3, ADC and PWM,
3. Enable Samsung SoC sound.

----------------------------------------------------------------
Alim Akhtar (1):
      arm64: defconfig: Enable S2MPS11 clock and S3C RTC driver

Krzysztof Kozlowski (1):
      arm64: defconfig: Enable more IP blocks for Exynos7 and Exynos5433

 arch/arm64/configs/defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)
