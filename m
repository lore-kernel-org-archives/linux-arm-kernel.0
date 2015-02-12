From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Thu, 12 Feb 2015 21:49:21 +0100
Subject: [PATCHv2 0/2] drm: atmel-hlcdc: PM support
Message-ID: <1423774163-4752-1-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series depends on Boris' "[PATCH v2] drm: atmel-hlcdc: Atomic
mode-setting conversion"
  <1423236143-6494-1-git-send-email-boris.brezillon@free-electrons.com>
plus a few fixes which are going to be in v3 of Boris' patch.

This series adds basic PM support for Atmel HLCDC.

Changes since v1:
  * (*crtc_funcs->disable)(crtc) replaced to crtc_funcs->disable(crtc)

Sylvain Rochet (2):
  drm: atmel-hlcdc: Add PM suspend/resume support
  drm: atmel-hlcdc: Add pinctrl PM select sleep,default state in CRTC
    suspend/resume

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c |  3 ++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c   | 60 ++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

-- 
2.1.4
