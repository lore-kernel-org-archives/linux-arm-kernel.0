From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Jan 2014 16:24:21 +0100
Subject: [GIT PULL] ux500 core changes for v3.14
Message-ID: <CACRpkdbWx31fSy_m_ZcoX3ZQ86Zz_XaCuiCXDSU11ifsT8if3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC people,

here is a rather late ux500 pull request for v3.14 (what's my exuse? vacation.)
It contains just two patches, so please consider pulling it in anyway I'm quite
certain they are both OK, else I'll just defer it to v3.15.

Yours,
Linus Walleij


The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-core-v3.14

for you to fetch changes up to ead9e2936b071a501f7c7ff709802ea4257cd23a:

  ARM: ux500: Enable system suspend with WFI support (2014-01-07 15:01:58 +0100)

----------------------------------------------------------------
Ux500 core patches for the v3.14 series:

- Enable PRINTK_TIME

- Enable suspend with WFI

----------------------------------------------------------------
Olof Johansson (1):
      ARM: ux500: turn on PRINTK_TIME in u8500_defconfig

Ulf Hansson (1):
      ARM: ux500: Enable system suspend with WFI support

 arch/arm/configs/u8500_defconfig |  1 +
 arch/arm/mach-ux500/pm.c         | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
