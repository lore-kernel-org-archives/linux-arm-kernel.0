From: olof@lixom.net (Olof Johansson)
Date: Fri,  8 Aug 2014 09:47:55 -0700
Subject: [GIT PULL 3/7] ARM: SoC board changes for 3.17
In-Reply-To: <1407516479-1251-1-git-send-email-olof@lixom.net>
References: <1407516479-1251-1-git-send-email-olof@lixom.net>
Message-ID: <1407516479-1251-4-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the smallest board branch we have ever had. Most of this is a
few cleanups for board code for Renesas shmobile, with a bit of legacy
driver support added. This is strongly trending in the right direction now.



Conflicts: None

----------------------------------------------------------------

The following changes since commit af0de725999369f7b9a6d2a0b41c09178b4814d8:

  Merge branch 'next/soc' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/boards-for-3.17

for you to fetch changes up to bdd18e8f76e33151a850906c8353222bd06a49e6:

  Merge tag 'renesas-boards-for-v3.17' of git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into next/boards

----------------------------------------------------------------

Geert Uytterhoeven (4):
      ARM: shmobile: koelsch-reference: Remove workarounds for core clock issues
      ARM: shmobile: lager-reference: Remove workarounds for core clock issues
      ARM: shmobile: armadillo800eva legacy: Add LED support
      ARM: shmobile: armadillo800eva reference: Spelling s/ED/LED/

Magnus Damm (1):
      ARM: shmobile: Enable R-Car Gen2 CMA code in board files

Olof Johansson (1):
      Merge tag 'renesas-boards-for-v3.17' of git://git.kernel.org/.../horms/renesas into next/boards


 .../board-armadillo800eva-reference.c           |  8 ++---
 arch/arm/mach-shmobile/board-armadillo800eva.c  | 35 ++++++++++++++++++++
 .../arm/mach-shmobile/board-koelsch-reference.c | 16 +--------
 arch/arm/mach-shmobile/board-koelsch.c          |  1 +
 arch/arm/mach-shmobile/board-lager-reference.c  | 15 +--------
 arch/arm/mach-shmobile/board-lager.c            |  1 +
 6 files changed, 43 insertions(+), 33 deletions(-)
