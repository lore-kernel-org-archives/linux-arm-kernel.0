From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 Sep 2013 09:24:11 +0200
Subject: [GIT PULL] ux500 fixes for v3.12
Message-ID: <CACRpkdZyE6XphN_dhhh1OCdS6-sF1ypUo9qryp=vbLOyQEUmLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

this seems to have got stuck in some limbo in my tree, sorry for that.
Please pull this in for fixes bound for the v3.12 RC:s so we have the
Snowball I2C devices on DT boots again.

Yours,
Linus Wallleij

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-fixes-v3.12-1

for you to fetch changes up to 0ec941e61c020ab6df8d39ae368000b31eb37ba3:

  ARM: ux500: Remove PrimeCell IDs from Nomadik I2C DT nodes
(2013-09-17 13:17:02 +0200)

----------------------------------------------------------------
Fix to make the Snowball boot properly from device tree
by not hardcoding the I2C PrimeCell IDs.

----------------------------------------------------------------
Lee Jones (1):
      ARM: ux500: Remove PrimeCell IDs from Nomadik I2C DT nodes

 arch/arm/boot/dts/ste-dbx5x0.dtsi | 5 -----
 1 file changed, 5 deletions(-)
