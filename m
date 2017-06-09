From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri,  9 Jun 2017 18:42:49 +0200
Subject: [GIT PULL 1/4] ARM: exynos: Soc for v4.13
In-Reply-To: <20170609164249.1656-1-krzk@kernel.org>
References: <20170609164249.1656-1-krzk@kernel.org>
Message-ID: <20170609164249.1656-5-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.13

for you to fetch changes up to 44fc41f92694241917a1590eb03081a68a38f480:

  ARM: s3c64xx: Do not select ARM_AMBA from S3C64XX_PL080 (2017-05-31 20:33:23 +0200)

----------------------------------------------------------------
Samsung mach/soc update for v4.13:
1. Fix possible circular Kconfig dependency on S3C64xx.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: s3c64xx: Do not select ARM_AMBA from S3C64XX_PL080

 arch/arm/mach-s3c64xx/Kconfig | 1 -
 1 file changed, 1 deletion(-)
