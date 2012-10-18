From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 18 Oct 2012 20:39:57 +0200
Subject: [GIT PULL] first set of ux500 for ARM SoC for v3.8
Message-ID: <CACRpkdasaP_xVfQtzq29UNJBXetrUUzqpn90T6_Gr0kOsV8GeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here are two small commits for v3.8 that I'd like to make sure
land in ARM SoC before I begin with all the other stuff.

Please pull them in!

Yours,
Linus Walleij

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
ux500-core

for you to fetch changes up to 4040d10a3d44023703f81083bb90a3eb45a39eee:

  ARM: ux500: add DB serial number to entropy pool (2012-10-15 13:53:55 +0200)

----------------------------------------------------------------
A first set of Ux500 core patches for v3.8:
- Support the HREF520 board
- Add the device serial number to the entropy pool

----------------------------------------------------------------
Linus Walleij (2):
      ARM: ux500: support the HREFP520 board variant
      ARM: ux500: add DB serial number to entropy pool

 arch/arm/mach-ux500/board-mop500.c | 13 +++++++++++--
 arch/arm/mach-ux500/cpu-db8500.c   |  5 ++++-
 2 files changed, 15 insertions(+), 3 deletions(-)
