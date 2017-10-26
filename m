From: philippe.cornu@st.com (Philippe Cornu)
Date: Thu, 26 Oct 2017 13:48:07 +0200
Subject: [PATCH v1 0/2] drm/stm: ltdc: add a 2nd endpoint
Message-ID: <1509018489-19641-1-git-send-email-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Version 1:
- Initial commit

The purpose of this set of patches is to offer the possibility
to use up to 2 endpoints for the ltdc dpi video port.

Philippe Cornu (2):
  dt-bindings: display: stm32: add a 2nd endpoint
  drm/stm: ltdc: add a 2nd endpoint

 .../devicetree/bindings/display/st,stm32-ltdc.txt  |  6 +-
 drivers/gpu/drm/stm/ltdc.c                         | 64 +++++++++++++++-------
 2 files changed, 50 insertions(+), 20 deletions(-)

-- 
1.9.1
