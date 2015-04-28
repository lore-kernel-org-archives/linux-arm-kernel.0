From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Apr 2015 14:45:58 +0200
Subject: [GIT PULL] Ux500 fixes
Message-ID: <CACRpkdZMCaCgJ89xPPy9pMRYDinuWwvBrXm+uKF12Ls4cNxvNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC guys,

this are three patches fixing an issue in the Ux500 with SD/MMC
GPIO regulators. All DTS fixes. Please pull it in for fixes.

Yours,
Linus Walleij

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/stericsson-fixes-v4.1

for you to fetch changes up to 11133db7a836b0cb411faa048f07a38e994d1382:

  ARM: ux500: Enable GPIO regulator for SD-card for snowball
(2015-04-27 09:01:02 +0200)

----------------------------------------------------------------
This fixes an MMC/SD configuration issue present for some time
in the Ux500 DT but triggered by proper error handling in v4.1-rc1.

----------------------------------------------------------------
Ulf Hansson (3):
      ARM: ux500: Move GPIO regulator for SD-card into board DTSs
      ARM: ux500: Enable GPIO regulator for SD-card for HREF boards
      ARM: ux500: Enable GPIO regulator for SD-card for snowball

 arch/arm/boot/dts/ste-dbx5x0.dtsi  | 17 -----------------
 arch/arm/boot/dts/ste-href.dtsi    | 15 +++++++++++++++
 arch/arm/boot/dts/ste-snowball.dts | 13 +++++++++++++
 3 files changed, 28 insertions(+), 17 deletions(-)
