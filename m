From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 14 Jul 2016 11:31:24 +0800
Subject: [PATCH 0/6] drm/rockchip: some fixes
Message-ID: <1468467090-6108-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some fixes for drm/rockchip:

These following patches were sent to upstream, seems no doubt about them,
I just rebase them to newest Dave's branch and resent.
  drm/rockchip: vop: correct the source size of uv scale factor setting
  drm/rockchip: vop: add uv_vir register field for RK3036 VOP
  drm/rockchip: fix "should it be static?" warnings
  drm/rockchip: fb: add missing header
  drm/rockchip: dw_hdmi: remove unused #include

This patch is new one, only register rename
  drm/rockchip: vop: correct rk3036 register define

John Keeping (3):
  drm/rockchip: dw_hdmi: remove unused #include
  drm/rockchip: fb: add missing header
  drm/rockchip: fix "should it be static?" warnings

Mark Yao (2):
  drm/rockchip: vop: correct the source size of uv scale factor setting
  drm/rockchip: vop: correct rk3036 register define

Yakir Yang (1):
  drm/rockchip: vop: add uv_vir register field for RK3036 VOP

 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 1 -
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 3 ++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 8 ++++----
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 7 ++++---
 5 files changed, 11 insertions(+), 10 deletions(-)

-- 
1.9.1
