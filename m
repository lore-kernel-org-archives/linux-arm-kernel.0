From: philippe.cornu@st.com (Philippe Cornu)
Date: Thu, 25 Jan 2018 11:37:58 +0100
Subject: [PATCH v2 0/2] drm/bridge/synopsys: dsi: Add fix & warning in
 dsi_host_transfer()
Message-ID: <20180125103800.1999-1-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a fix & a warning in the dsi_host_transfer().

Version 2:
- Simplify the 2 patches following comments from Brian Norris.
- Swap the 2 patches as the return value is only on tx and
  in case of rx requests the warning is there.

Version 1:
- Initial commit

Philippe Cornu (2):
  drm/bridge/synopsys: dsi: Add a warning msg on dsi read requests
  drm/bridge/synopsys: dsi: Fix dsi_host_transfer() return value

 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

-- 
2.15.1
