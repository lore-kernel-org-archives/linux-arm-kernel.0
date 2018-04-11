From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Apr 2018 17:19:37 +0200
Subject: [GIT PULL] ARM: SoC fixes for 4.17
Message-ID: <CAK8P3a0ibBNw14DfgqXJqmH8QgtEdZ5spLnFRLh2bU7uoMHoSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 38c23685b273cfb4ccf31a199feccce3bdcb5d83:

  Merge tag 'armsoc-drivers' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2018-04-05
21:29:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-fixes

for you to fetch changes up to cb799267bb65676277fb718cfb42239fe5c6e4fb:

  MAINTAINERS: Update ASPEED entry with details (2018-04-11 10:47:31 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 4.17

Here is a very small set of fixes for inclusion in linux-4.17-rc1:
Two changes for the maintainer file, and one more fix for the newly
added npcm platform, to enable the level 2 cache controller.

----------------------------------------------------------------
Joel Stanley (1):
      MAINTAINERS: Update ASPEED entry with details

Neil Armstrong (1):
      MAINTAINERS: Migrate oxnas list to groups.io

Tomer Maimon (1):
      arm: npcm: enable L2 cache in NPCM7xx architecture

 MAINTAINERS                  | 11 ++++++++---
 arch/arm/mach-npcm/npcm7xx.c |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)
