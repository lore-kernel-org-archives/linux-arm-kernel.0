From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 25 Jul 2018 18:23:40 +0200
Subject: [GIT PULL 3/3] ARM: samsung: Mach/soc for v4.19
In-Reply-To: <20180725162340.7488-1-krzk@kernel.org>
References: <20180725162340.7488-1-krzk@kernel.org>
Message-ID: <20180725162340.7488-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Rebased on v4.18-rc2, because at v4.18-rc1 the NFS root boot, which I use at my
testing setup (https://krzk.eu), was broken.

Best regards,
Krzysztof


The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.19

for you to fetch changes up to cd4806911cee3901bc2b5eb95603cf1958720b57:

  ARM: exynos: Clear global variable on init error path (2018-07-24 18:52:14 +0200)

----------------------------------------------------------------
Samsung mach/soc changes for v4.19

Minor cleanups and fixes.

----------------------------------------------------------------
Denis Efremov (1):
      ARM: s3c24xx: Fix typo in guard macro of s3c2412.h

Krzysztof Kozlowski (2):
      ARM: exynos: Remove outdated maintainer information
      ARM: exynos: Clear global variable on init error path

 arch/arm/mach-exynos/exynos.c                | 2 --
 arch/arm/mach-exynos/suspend.c               | 1 +
 arch/arm/mach-s3c24xx/include/mach/s3c2412.h | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)
