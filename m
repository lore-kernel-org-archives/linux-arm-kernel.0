From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 28 Nov 2016 13:15:26 +0100
Subject: [PATCH v2 0/2] ARM: dts: da850: tilcdc related DT changes
Message-ID: <1480335328-4010-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains the last DT changes required for LCDC support
on da850-lcdk. The first one adds the dumb-vga-dac nodes, the second
limits the maximum pixel clock rate.

v1 -> v2:
- drop patch 3/3 (already merged)
- use max-pixelclock instead of max-bandwidth for display mode limiting

Bartosz Golaszewski (2):
  ARM: dts: da850-lcdk: add the dumb-vga-dac node
  ARM: dts: da850-lcdk: specify the maximum pixel clock rate for tilcdc

 arch/arm/boot/dts/da850-lcdk.dts | 59 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi     | 17 ++++++++++++
 2 files changed, 76 insertions(+)

-- 
2.9.3
