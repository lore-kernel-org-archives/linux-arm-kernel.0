From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Nov 2013 21:27:26 +0100
Subject: [GIT PULL] ux500 defconfig changed for v3.13-rcs
Message-ID: <CACRpkdZ_EN7OPqfqva2BZr4RQGHKjb+JM0TtK+WwxXOESOLgqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here are two defconfig patches that I think should go into the
release candidates for v3.13.

Please pull them in!

Yours,
Linus Walleij


The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-defconfig-v3.13-rcs

for you to fetch changes up to 59b023e9bf62933f7078dec339b110d5785f63f6:

  ARM: ux500: u8500_defconfig: add missing cpuidle option (2013-11-26
21:01:40 +0100)

----------------------------------------------------------------
Ux500 defconfig patches for the v3.13 rc series:

- Allow creation and mounting of devtmpfs, which is used
  by OpenEmbedded root filesystems among others.

- Enable CPUidle for the ux500, it has been accidentally
  disabled due to a Kconfig change.

----------------------------------------------------------------
Andi Shyti (1):
      u8500_defconfig: allow creation and mounting of devtmpfs

Daniel Lezcano (1):
      ARM: ux500: u8500_defconfig: add missing cpuidle option

 arch/arm/configs/u8500_defconfig | 3 +++
 1 file changed, 3 insertions(+)
