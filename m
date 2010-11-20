From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 20 Nov 2010 10:59:06 +0100
Subject: rm9200: update
Message-ID: <20101120095906.GD4216@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	this patch update some issues found on rm9200
	during the test of the rm9200 defconfig consolidation

The following changes since commit b86db4744230c94e480de56f1b7f31117edbf193:

  Merge branch 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 (2010-11-19 19:46:45 -0800)

are available in the git repository at:

  git://git.jcrosoft.org/linux-2.6.git rm9200

Jean-Christophe PLAGNIOL-VILLARD (6):
      at91: Convert remaining boards to new-style UART initialization
      at91rm9200dk: fix warning: 'dk_mmc_data' defined but not used
      at91rm9200ek: fix warning: 'ek_mmc_data' defined but not used
      at91/picotux200: fix warning: 'picotux200_mmc_data' defined but not used
      at91: rename rm9200ek and rm9200dk board file name
      atmel_spi: fix warning In function 'atmel_spi_dma_map_xfer'

 arch/arm/mach-at91/Makefile                        |    4 +-
 arch/arm/mach-at91/at91rm9200_devices.c            |   45 --------------------
 arch/arm/mach-at91/board-1arm.c                    |   26 ++++++------
 arch/arm/mach-at91/board-kafa.c                    |   21 ++++------
 arch/arm/mach-at91/board-picotux200.c              |   25 +++++------
 .../arm/mach-at91/{board-dk.c => board-rm9200dk.c} |    2 +
 .../arm/mach-at91/{board-ek.c => board-rm9200ek.c} |    2 +
 arch/arm/mach-at91/include/mach/board.h            |    6 ---
 drivers/spi/atmel_spi.c                            |    4 +-
 9 files changed, 42 insertions(+), 93 deletions(-)
 rename arch/arm/mach-at91/{board-dk.c => board-rm9200dk.c} (99%)
 rename arch/arm/mach-at91/{board-ek.c => board-rm9200ek.c} (99%)

Best Regards,
J.
