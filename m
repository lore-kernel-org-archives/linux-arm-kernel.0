From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 May 2017 10:35:44 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.12
Message-ID: <cover.1493713942.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC fixes for v4.12.

* Fix from Geert Uytterhoeven to avoid an undefined reference
  to `rcar_rst_read_mode_pins' in the case where the R-Car RST driver
  is not included.


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v4.12

for you to fetch changes up to 7b4ccb3c466f62bbf2f4dd5d6a143d945a6f3051:

  soc: renesas: Provide dummy rcar_rst_read_mode_pins() for compile-testing (2017-04-28 10:07:36 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC Fixes for v4.12

* Provide dummy rcar_rst_read_mode_pins() for compile-testing

----------------------------------------------------------------
Geert Uytterhoeven (1):
      soc: renesas: Provide dummy rcar_rst_read_mode_pins() for compile-testing

 include/linux/soc/renesas/rcar-rst.h | 5 +++++
 1 file changed, 5 insertions(+)
