From: philippe.cornu@st.com (Philippe CORNU)
Date: Tue, 4 Jul 2017 18:30:02 +0200
Subject: [PATCH v1 0/3] Add support for the otm8009a dsi panel
Message-ID: <1499185805-23354-1-git-send-email-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

The purpose of this patch is to add support for the Orise Tech
otm8009a 3.97" 480x800 TFT LCD panel (MIPI-DSI video mode).
This LCD panel is used in several STM32 boards.

Version 1:
- Initial commit

Best regards,
Philippe

Philippe CORNU (3):
  dt-bindings: Add vendor prefix for Orise Technology
  dt-bindings: display: panel: Add support for Orise Tech otm8009a dsi
    panel
  drm/panel: Add support for otm8009a panel driver

 .../bindings/display/panel/orisetech,otm8009a.txt  |  20 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/gpu/drm/panel/Kconfig                      |   9 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c   | 517 +++++++++++++++++++++
 5 files changed, 548 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
 create mode 100755 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c

-- 
1.9.1
