From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 13 Jan 2017 16:32:25 +0200
Subject: [GIT PULL] ARM: exynos: Fixes for v4.10
Message-ID: <20170113143225.11311-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Just a couple of minor fixes for this release cycle.

Best regards,
Krzysztof


The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-fixes-4.10

for you to fetch changes up to 3ef01c968fbfb21c2f16281445d30a865ee4412c:

  ARM: s3c2410_defconfig: Fix invalid values for NF_CT_PROTO_* (2017-01-02 21:05:34 +0200)

----------------------------------------------------------------
Samsung fixes for v4.10:
1. Update maintainers entry with Patchwork address.
2. Fix invalid values for NF_CT_PROTO_* in s3c2410 defconfig (these options
   cannot be modules anymore).

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      MAINTAINERS: Add Patchwork URL to Samsung Exynos entry
      ARM: s3c2410_defconfig: Fix invalid values for NF_CT_PROTO_*

 MAINTAINERS                        | 1 +
 arch/arm/configs/s3c2410_defconfig | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)
