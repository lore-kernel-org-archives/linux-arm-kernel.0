From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 16 Oct 2017 17:34:43 +0200
Subject: [PATCH 0/2] clk: meson: gxbb: Add VPU and VAPB clocks
Message-ID: <1508168085-19032-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the VPU and VAPB clocks used to feed the Amlogic Meson
GX SoC Video Processing Unit and it's power domain.

Neil Armstrong (2):
  clk: meson: gxbb: Add VPU and VAPB clockids
  clk: meson: gxbb: Add VPU and VAPB clocks data

 drivers/clk/meson/gxbb.c              | 292 ++++++++++++++++++++++++++++++++++
 drivers/clk/meson/gxbb.h              |   6 +-
 include/dt-bindings/clock/gxbb-clkc.h |  11 ++
 3 files changed, 308 insertions(+), 1 deletion(-)

-- 
2.7.4
