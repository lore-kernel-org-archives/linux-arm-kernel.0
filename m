From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 23 Aug 2017 18:36:34 +0200
Subject: [GIT PULL 2/3] ARM: exynos: Changes for v4.14
In-Reply-To: <20170823163635.6064-1-krzk@kernel.org>
References: <20170823163635.6064-1-krzk@kernel.org>
Message-ID: <20170823163635.6064-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Just one commit. If needed you can also cherry-pick it directly.
Based on top of previous pull request.

Best regards,
Krzysztof


The following changes since commit f991ce429a420dbb42b3e4b5a47490c84390d7e1:

  ARM: s3c24xx: make H1940BT depend on RFKILL (2017-07-20 20:26:24 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.14-2

for you to fetch changes up to 225bd1de16fb2e330be5bad261d427d00293c55e:

  ARM: s3c24xx: Fix NAND ECC mode for mini2440 board (2017-08-21 19:50:51 +0200)

----------------------------------------------------------------
Samsung mach/soc changes for v4.14, part 2

Fix NAND ECC mode for mini2440 board.

----------------------------------------------------------------
Sylwester Nawrocki (1):
      ARM: s3c24xx: Fix NAND ECC mode for mini2440 board

 arch/arm/mach-s3c24xx/mach-mini2440.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
