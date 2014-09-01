From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 1 Sep 2014 15:00:10 +0530
Subject: [GIT PULL] DaVinci board file fixes for v3.18 (merge window)
Message-ID: <54043CA2.1090301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.18/board

for you to fetch changes up to 9e9bc235580829e3a06ccd13aa10110478c2e093:

  ARM: davinci: board-da850-evm: Add needed regulators for tlv320aic3106 codec (2014-08-26 15:43:51 +0530)

----------------------------------------------------------------
Some non-critcal fixes for DA850 EVM board file
adding missing regulator information.

----------------------------------------------------------------
Peter Ujfalusi (2):
      ARM: davinci: board-da850-evm: Mark dcdc2 of TPS65070 as always_on
      ARM: davinci: board-da850-evm: Add needed regulators for tlv320aic3106 codec

 arch/arm/mach-davinci/board-da850-evm.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)
