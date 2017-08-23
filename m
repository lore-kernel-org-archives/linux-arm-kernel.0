From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 23 Aug 2017 18:36:33 +0200
Subject: [GIT PULL 1/3] soc: samsung: exynos for v4.14
Message-ID: <20170823163635.6064-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Just one commit. If needed you can also cherry-pick it directly.

Best regards,
Krzysztof


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-4.14-2

for you to fetch changes up to e83a71981181a36d36e18e2f2dae3ec84fc37429:

  soc: samsung: Use kbasename instead of open coding (2017-07-24 06:47:50 +0200)

----------------------------------------------------------------
Samsung soc drivers changes for v4.14

Conversion to kbasename from Rob Herring.

----------------------------------------------------------------
Rob Herring (1):
      soc: samsung: Use kbasename instead of open coding

 drivers/soc/samsung/pm_domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
