From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 10 Oct 2018 20:25:57 +0200
Subject: [GIT PULL 3/4] ARM: exynos: soc/mach for v4.20, second round
In-Reply-To: <20181010182558.7034-1-krzk@kernel.org>
References: <20181010182558.7034-1-krzk@kernel.org>
Message-ID: <20181010182558.7034-4-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit f30858439e7db9ce9847eaedf440635fc6349c6e:

  ARM: s3c24xx: Restore proper usage of pr_info/pr_cont (2018-09-19 19:11:17 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.20-2

for you to fetch changes up to 6862fdf2201ab67cd962dbf0643d37db909f4860:

  ARM: samsung: Limit SAMSUNG_PM_CHECK config option to non-Exynos platforms (2018-10-01 18:42:48 +0200)

----------------------------------------------------------------
Samsung mach/soc changes for v4.20, second round

1. Disable SAMSUNG_PM_CHECK Kconfig feature incompatible with Exynos.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      ARM: samsung: Limit SAMSUNG_PM_CHECK config option to non-Exynos platforms

 arch/arm/plat-samsung/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
