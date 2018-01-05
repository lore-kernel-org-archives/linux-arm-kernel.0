From: will.deacon@arm.com (Will Deacon)
Date: Fri, 5 Jan 2018 12:10:07 +0000
Subject: [GIT PULL] iommu/arm-smmu: Fixes for 4.15
Message-ID: <20180105121007.GA17912@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex, Joerg,

Please pull these two ARM SMMU fixes for 4.15. Sorry they're so late, but
a combination of the christmas break and the recent security issues mean
I've fallen a bit behind on the SMMU front.

Cheers,

Will

--->8

The following changes since commit 30a7acd573899fd8b8ac39236eff6468b195ac7d:

  Linux 4.15-rc6 (2017-12-31 14:47:43 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/fixes

for you to fetch changes up to 563b5cbe334e9503ab2b234e279d500fc4f76018:

  iommu/arm-smmu-v3: Cope with duplicated Stream IDs (2018-01-02 16:45:51 +0000)

----------------------------------------------------------------
Jean-Philippe Brucker (1):
      iommu/arm-smmu-v3: Don't free page table ops twice

Robin Murphy (1):
      iommu/arm-smmu-v3: Cope with duplicated Stream IDs

 drivers/iommu/arm-smmu-v3.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)
