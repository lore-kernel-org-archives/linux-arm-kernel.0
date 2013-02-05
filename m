From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 5 Feb 2013 10:58:44 +0100
Subject: [GIT PULL] i.MX clock fixes for v3.8
Message-ID: <20130205095844.GZ1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull these two fixes for v3.8

Sascha

The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:

  Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/arm-imx-clk-fixes

for you to fetch changes up to 4b526ca5f627188425184a22ed46c91baa602d43:

  ARM: i.MX25: clk: parent per5_clk to AHB clock (2013-02-05 10:54:35 +0100)

----------------------------------------------------------------
ARM: i.MX: clock fixes

- fix wrong timer clock on i.MX25 leading to strange timing inconsistencies
- fix SPI clocks for i.MX27

----------------------------------------------------------------
Gwenhael Goavec-Merou (1):
      ARM: imx27: clk-imx27: SPI: Rename IPG clock and add PER clock

Steffen Trumtrar (1):
      ARM: i.MX25: clk: parent per5_clk to AHB clock

 arch/arm/mach-imx/clk-imx25.c |    3 +++
 arch/arm/mach-imx/clk-imx27.c |    9 ++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
