From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 1 Sep 2014 14:41:02 +0530
Subject: [GIT PULL] DaVinci fixes for v3.17
Message-ID: <54043826.4040007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v3.17-rc4

for you to fetch changes up to 929a015b1809a30748d487f9d25b16a41434b61a:

  ARM: edma: Fix configuration parsing for SoCs with multiple eDMA3 CC (2014-08-26 14:49:15 +0530)

----------------------------------------------------------------
This patch fixes setup of second EDMA channel controller
on DA850.

----------------------------------------------------------------
Peter Ujfalusi (1):
      ARM: edma: Fix configuration parsing for SoCs with multiple eDMA3 CC

 arch/arm/common/edma.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)
