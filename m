From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 11 Jul 2016 18:41:16 +0200
Subject: [GIT PULL 2/4] ARM: exynos: Stuff for v4.8, last round
In-Reply-To: <1468255278-32162-1-git-send-email-k.kozlowski@samsung.com>
References: <1468255278-32162-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1468255278-32162-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Last round of commits for v4.8. On top of previous tag.

Best regards,
Krzysztof


The following changes since commit 1c03274d68f4744afe582fcff1c2e5b1c5c34b5b:

  MAINTAINERS: Extend Samsung SoC entry with S3C/S5P drivers (2016-06-23 08:12:08 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.8-3

for you to fetch changes up to 3981b11fda14ea0b459043d97c68db0a614ec9f8:

  ARM: s3c64xx: smartq: Avoid sparse warnings (2016-07-11 17:44:11 +0200)

----------------------------------------------------------------
Samsung mach/soc update for v4.8, part 3:
Just cleanup - fix Sparse warning and constify passed iomem address.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: SAMSUNG: Constify iomem address passed to s5p_init_cpu

Thierry Reding (1):
      ARM: s3c64xx: smartq: Avoid sparse warnings

 arch/arm/mach-s3c64xx/mach-smartq.c      | 1 +
 arch/arm/plat-samsung/cpu.c              | 2 +-
 arch/arm/plat-samsung/include/plat/cpu.h | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)
