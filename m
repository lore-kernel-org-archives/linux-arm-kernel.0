From: wxt@rock-chips.com (Caesar Wang)
Date: Tue, 31 Mar 2015 18:22:49 +0800
Subject: [PATCH 0/1] drm: rockchip: Turn off VT switching on suspend
Message-ID: <1427797370-32441-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drm/rockchip already has support for disabling all displays on suspend
and enabling them on resume.

Disable automatic VT switching on suspend by the pm console tracking
layer.

Tested on veyron, used `echo mem > sys/power/state`
  => verified no VT switch.



Caesar Wang (1):
  drm: rockchip: Turn off VT switching on suspend

 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
1.9.1
