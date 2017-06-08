From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  8 Jun 2017 17:31:19 +0200
Subject: [PATCH 0/4] ARM64: dts: meson-gx: Add HDMI and CVBS nodes for
 selected boards
Message-ID: <1496935883-4966-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the CVBS and HDMI nodes for the following boards :
 - Wetek Play2
 - Khadas VIM
 - Amlogic P230 Reference board
 - Amlogic P212 Reference board

Neil Armstrong (4):
  ARM64: dts: meson-gxbb-wetek-play2: Add HDMI and CVBS Nodes
  ARM64: dts: meson-gxl-s905d-p230: Add HDMI nodes
  ARM64: dts: meson-gxl-s905x-khadas-vim: Add HDMI nodes
  ARM64: dts: meson-gxl-s905x-p212: Add HDMI and CVBS nodes

 .../boot/dts/amlogic/meson-gxbb-wetek-play2.dts    | 40 ++++++++++++++++++++++
 .../boot/dts/amlogic/meson-gxl-s905d-p230.dts      | 24 +++++++++++++
 .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts     | 23 +++++++++++++
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dts      | 23 +++++++++++++
 4 files changed, 110 insertions(+)

-- 
1.9.1
