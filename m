From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 27 Jul 2017 15:09:38 +0200
Subject: [PATCH 0/2] clk: meson: gxbb: fix audio divider flags
Message-ID: <20170727130940.18005-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two audio clocks incorrectly set divider flags in the hw.init flag.
Just move these flags where they belong.

Jerome Brunet (2):
  clk: meson: gxbb: fix meson cts_amclk divider flags
  clk: meson: gxbb: fix clk_mclk_i958 divider flags

 drivers/clk/meson/gxbb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.9.4
