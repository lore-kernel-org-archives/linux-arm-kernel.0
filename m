From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 20 Nov 2014 21:13:00 +0530
Subject: [GIT PULL] DaVinci updates for v3.19 - edma
Message-ID: <1416498181-15988-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.19/edma

for you to fetch changes up to a2b1175131ccb5d4a15456f4f31836356abbce09:

  ARM: common: edma: add suspend resume hook (2014-11-18 21:26:02 +0530)

----------------------------------------------------------------
Adds suspend/resume support to EDMA driver.

----------------------------------------------------------------
Daniel Mack (1):
      ARM: common: edma: add suspend resume hook

 arch/arm/common/edma.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)
