From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 11 Jul 2016 18:41:17 +0200
Subject: [GIT PULL 3/4] arm64: dts: exynos: Minor fix for v4.8, last round
In-Reply-To: <1468255278-32162-1-git-send-email-k.kozlowski@samsung.com>
References: <1468255278-32162-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1468255278-32162-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Last round of commits for v4.8.

Best regards,
Krzysztof


The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.8-2

for you to fetch changes up to a1924466b784fbb64f10eeb213d335e3d1728b8b:

  arm64: dts: exynos: Modify the voltage range for BUCK2 for exynos7 (2016-07-06 09:43:42 +0200)

----------------------------------------------------------------
Samsung DeviceTree changes for ARM64 for v4.8:
1. Adjust the voltage of CPU buck regulator so scaling could work.

----------------------------------------------------------------
Abhilash Kesavan (1):
      arm64: dts: exynos: Modify the voltage range for BUCK2 for exynos7

 arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
