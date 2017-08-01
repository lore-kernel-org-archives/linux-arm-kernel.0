From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 1 Aug 2017 14:21:08 +0200
Subject: [GIT PULL v2] Meson clock fixes for 4.13-rc4
Message-ID: <5af2832c-c23c-c42b-c19f-ba7cb10c27c8@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Here is a fix for Meson GXBB driver, that could go for 4.13-rc4.

Thanks,
Neil

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://github.com/baylibre/clk-meson.git tags/meson-clk-fixes-for-4.13-rc4-v2

for you to fetch changes up to 1f737ffa13efd3da2c703d45894ea234e9290c89:

  clk: meson: mpll: fix mpll0 fractional part ignored (2017-08-01 14:18:31 +0200)

----------------------------------------------------------------
Meson Clock fixes:
- mpll: fix mpll0 fractional part ignored

----------------------------------------------------------------
Jerome Brunet (1):
      clk: meson: mpll: fix mpll0 fractional part ignored

 drivers/clk/meson/clk-mpll.c | 7 +++++++
 drivers/clk/meson/clkc.h     | 1 +
 drivers/clk/meson/gxbb.c     | 5 +++++
 drivers/clk/meson/meson8b.c  | 5 +++++
 4 files changed, 18 insertions(+)
