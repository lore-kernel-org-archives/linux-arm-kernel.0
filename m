From: philippe.cornu@st.com (Philippe Cornu)
Date: Tue, 23 Jan 2018 15:26:16 +0100
Subject: [PATCH v1 0/2] drm/bridge/synopsys: dsi: Add fix & warning in
 dsi_host_transfer()
Message-ID: <20180123142618.28384-1-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a fix & a warning in the dsi_host_transfer().

Philippe Cornu (2):
  drm/bridge/synopsys: dsi: Fix dsi_host_transfer() return value
  drm/bridge/synopsys: dsi: Add a warning msg on dsi read operations

 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
2.15.1
