From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2016 17:01:48 +0100
Subject: [GIT PULL] iommu/arm-smmu: Fixes for 4.9
Message-ID: <20161028160148.GD1076@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Please pull the following pair of fixes from Robin for the ARM SMMU
drivers.

Thanks,

Will

--->8

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/fixes

for you to fetch changes up to 5a5a057d2ba73ae4990b6dc283465b4886d93993:

  iommu/arm-smmu: Don't inadvertently reject multiple SMMUv3s (2016-10-26 19:21:38 +0100)

----------------------------------------------------------------
Robin Murphy (2):
      iommu/arm-smmu: Work around ARM DMA configuration
      iommu/arm-smmu: Don't inadvertently reject multiple SMMUv3s

 drivers/iommu/arm-smmu-v3.c | 11 ++++-------
 drivers/iommu/arm-smmu.c    | 10 ++++++++++
 2 files changed, 14 insertions(+), 7 deletions(-)
