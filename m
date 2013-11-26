From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Nov 2013 21:24:55 +0100
Subject: [GIT PULL] ux500 fixes for v3.13-rcN
Message-ID: <CACRpkdYi=_9PMuz5hm5cPBjfyTefQjzqZx2KKhS76VVmqYfUEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here are two fixes for the Ux500 v3.13 series making (e)MMC/SD
cards work again.

Please pull them in for fixes!

Yours,
Linus Walleij


The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-fixes-v3.13-1

for you to fetch changes up to 5281973012bdcfd93a8f6e0f5b4e04af0038ea99:

  Revert "ARM: ux500: Stop passing MMC's platform data for Device Tree
boots" (2013-11-26 21:02:20 +0100)

----------------------------------------------------------------
Ux500 fixes for the v3.13 series:

- Restore platform data for the (e)MMC/SD controllers, so they can
  pins and special flags properly like before.

----------------------------------------------------------------
Linus Walleij (2):
      Revert "ARM: ux500: Remove AUXDATA relating to SDI (MMC)
clock-name bindings"
      Revert "ARM: ux500: Stop passing MMC's platform data for Device
Tree boots"

 arch/arm/mach-ux500/cpu-db8500.c | 4 ++++
 1 file changed, 4 insertions(+)
