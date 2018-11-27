From: eric@anholt.net (Eric Anholt)
Date: Tue, 27 Nov 2018 13:12:59 -0800
Subject: [GIT PULL 2/4] bcm2835-soc-next-2018-11-27
In-Reply-To: <20181127211301.30296-1-eric@anholt.net>
References: <20181127211301.30296-1-eric@anholt.net>
Message-ID: <20181127211301.30296-2-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-soc-next-2018-11-27

for you to fetch changes up to 7b369a42e6d06c59fc56a1769fb4da797fac9bad:

  ARM: mach-bcm: Switch bcm2835 and platsmp to SPDX identifier (2018-11-14 20:55:30 +0100)

----------------------------------------------------------------
This pull request adds SPDX identifiers to the bcm2835 platform files.

----------------------------------------------------------------
Stefan Wahren (1):
      ARM: mach-bcm: Switch bcm2835 and platsmp to SPDX identifier

 arch/arm/mach-bcm/board_bcm2835.c | 11 +----------
 arch/arm/mach-bcm/platsmp.c       | 10 +---------
 arch/arm/mach-bcm/platsmp.h       |  6 +-----
 3 files changed, 3 insertions(+), 24 deletions(-)
