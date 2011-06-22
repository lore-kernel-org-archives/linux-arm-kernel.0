From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 22 Jun 2011 13:34:50 +0200
Subject: [PATCH 0/6] mach-ux500: Snowball support
Message-ID: <1308742490-22363-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This patchset adds support for the ST-Ericsson Snowball community
board to the kernel.
http://www.igloocommunity.org/

This is a reworked version - consolidated! - of the earlier patch
set which created new board files etc. We concluded that the
differences were not big enough to warrant a separate board file
and instead folded the support into the existing MOP500 board
support.

Mathieu J. Poirier (3):
  mach-ux500: setting proper uart for snowball
  mach-ux500: Add SDI support for snowball board
  mach-ux500: Kconfig for snowball board

Robert Marklund (3):
  mach-ux500: add basic support for snowball board
  mach-ux500: Add pin configuration for snowball board
  mach-ux500: add configs for snowball board

 arch/arm/configs/u8500_defconfig              |   26 +++-
 arch/arm/mach-ux500/Kconfig                   |    7 +
 arch/arm/mach-ux500/board-mop500-pins.c       |   43 +++++++
 arch/arm/mach-ux500/board-mop500-sdi.c        |   19 +++-
 arch/arm/mach-ux500/board-mop500.c            |  151 +++++++++++++++++++++++--
 arch/arm/mach-ux500/board-mop500.h            |    5 +
 arch/arm/mach-ux500/include/mach/uncompress.h |    3 +-
 7 files changed, 233 insertions(+), 21 deletions(-)

-- 
1.7.3.2
