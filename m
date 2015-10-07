From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Oct 2015 10:50:26 +0100
Subject: [GIT PULL] iommu/arm-smmu: Fixes for 4.3
Message-ID: <20151007095025.GE16065@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Here are a handful of arm-smmu and io-pgtable fixes for 4.3. I would
have liked to send these earlier, but I was travelling and couldn't test
them properly, so they ended up waiting until this week.

Please pull.

Thanks,

Will

--->8

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/fixes

for you to fetch changes up to 1c27df1c0a82b938d8073a60243ff62eff8056b5:

  iommu/arm-smmu: Use correct address mask for CMD_TLBI_S2_IPA (2015-09-22 17:36:05 +0100)

----------------------------------------------------------------
Robin Murphy (1):
      iommu/io-pgtable-arm: Don't use dma_to_phys()

Will Deacon (2):
      iommu/arm-smmu: Ensure IAS is set correctly for AArch32-capable SMMUs
      iommu/arm-smmu: Use correct address mask for CMD_TLBI_S2_IPA

 drivers/iommu/Kconfig          |  3 +--
 drivers/iommu/arm-smmu-v3.c    | 21 +++++++++++++++------
 drivers/iommu/io-pgtable-arm.c | 24 +++++++++++++-----------
 3 files changed, 29 insertions(+), 19 deletions(-)
