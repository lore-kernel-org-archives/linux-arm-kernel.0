From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 May 2014 18:23:34 +0100
Subject: [GIT PULL] iommu/arm-smmu: updates for 3.16
Message-ID: <20140506172333.GD13677@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Please can you pull the following arm-smmu changes for 3.16?

There's not a lot here, but a non-essential fix (removing a extra shift by
0) and replacing a hard-coded constant with its corresponding definition
(which actually means we can support up to 42-bit addresses into stage-2).

Cheers,

Will

--->8

The following changes since commit d1db0eea852497762cab43b905b879dfcd3b8987:

  Linux 3.15-rc3 (2014-04-27 19:29:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 6069d23ce0e568909d847f28af0257b085e8e77a:

  iommu/arm-smmu: fix incorrect use of S2CR_TYPE_SHIFT (2014-05-02 16:49:37 +0100)

----------------------------------------------------------------
Kefeng Wang (1):
      iommu/arm-smmu: fix incorrect use of S2CR_TYPE_SHIFT

Will Deacon (1):
      iommu/arm-smmu: allow 42-bit stage-1 output size with 64K pages

 drivers/iommu/arm-smmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
