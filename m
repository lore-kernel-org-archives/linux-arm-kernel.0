From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Tue, 10 Feb 2015 14:40:44 +0100
Subject: [PATCH 0/2] drm: atmel-hlcdc: PM support
Message-ID: <1423575646-3273-1-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series depends on Boris' "[PATCH v2] drm: atmel-hlcdc: Atomic 
mode-setting conversion"
  <1423236143-6494-1-git-send-email-boris.brezillon@free-electrons.com>
plus a few fixes which are going to be in v3 of Boris' patch.

This series adds basic PM support for Atmel HLCDC.

Sylvain Rochet (2):
  drm: atmel-hlcdc: Add PM suspend/resume support
  drm: atmel-hlcdc: Add pinctrl PM select sleep,default state in CRTC
    suspend/resume

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c |  3 ++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c   | 60 ++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

-- 
2.1.4
