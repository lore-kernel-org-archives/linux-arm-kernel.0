From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Mar 2013 10:11:27 +0100
Subject: [GIT PULL] ux500 core changes for v3.10
Message-ID: <CACRpkdaWq_hyNfPhY+_pyj7fZuQ5hbep6KoOO_+guize_trtDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

here are two ux500 core patches that have been littering my tree,
they need to go upstream into some unspecified ux500 core branch.
These have been circulated on the list.

They are not causing any immediate regression so target is v3.10.

Please pull them in!

Yours,
Linus Walleij


The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-core-v3.10

for you to fetch changes up to 0f2fa40e464c955e928979331625b5485c292bf0:

  ARM: mach-ux500: enable 128KB way L2 cache on DB8540 (2013-03-18
13:49:58 +0100)

----------------------------------------------------------------
Two fixes to the ux500 core machine:
- Enable the 128KB cache on DB8540
- Bump the number of IRQs to the correct value

----------------------------------------------------------------
Linus Walleij (1):
      ARM: ux500: bump arch nr of GPIOs

Maxime Coquelin (1):
      ARM: mach-ux500: enable 128KB way L2 cache on DB8540

 arch/arm/Kconfig                 | 2 +-
 arch/arm/mach-ux500/cache-l2x0.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
