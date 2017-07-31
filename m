From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 31 Jul 2017 11:25:46 +0200
Subject: [GIT PULL] Meson clock fixes for 4.13-rc4
Message-ID: <ce41382f-fd93-1dc9-0dba-1484ac555945@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Here is some fixes for Meson GXBB and Meson8 drivers, that could go for 4.13-rc4.

Thanks,
Neil

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://github.com/baylibre/clk-meson.git tags/meson-clk-fixes-for-4.13-rc4

for you to fetch changes up to c1922eed58f38f3d7876f53e1000e3c3e3024e54:

  clk: meson: mpll: fix mpll0 fractional part ignored (2017-07-31 10:08:01 +0200)

----------------------------------------------------------------
Meson Clock fixes:
- gxbb: fix meson cts_amclk divider flags
- gxbb: fix clk_mclk_i958 divider flags
- meson8b: fix protection against undefined clks
- gxbb: fix protection against undefined clks
- mpll: fix mpll0 fractional part ignored

----------------------------------------------------------------
Jerome Brunet (5):
      clk: meson: gxbb: fix meson cts_amclk divider flags
      clk: meson: gxbb: fix clk_mclk_i958 divider flags
      clk: meson: meson8b: fix protection against undefined clks
      clk: meson: gxbb: fix protection against undefined clks
      clk: meson: mpll: fix mpll0 fractional part ignored

 drivers/clk/meson/clk-mpll.c |  7 +++++++
 drivers/clk/meson/clkc.h     |  1 +
 drivers/clk/meson/gxbb.c     | 17 +++++++++++++----
 drivers/clk/meson/meson8b.c  |  6 ++++++
 4 files changed, 27 insertions(+), 4 deletions(-)
