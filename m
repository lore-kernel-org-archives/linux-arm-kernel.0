From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue, 21 Jul 2015 16:20:01 +0800
Subject: [PATCH v3 0/6] drm/rockchip: fixes and new features
Message-ID: <1437466807-13689-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series patches are used for yuv image overlay display.

Rockchip vop support NV11, NV16, NV24 yuv format,
and can scale the image scale 1/8 to 8.

Changes in v3:
- make code more readable
- fix some bugs

Changes in v2:
- Uv buffer not support odd offset, align it.
- Fix error display when move yuv image. 
- Fix scale dest info. 
Mark Yao (6):
  drm/rockchip: vop: Fix virtual stride calculation
  drm/rockchip: vop: Fix window dest start point
  drm/rockchip: vop: Add yuv plane support
  drm/rockchip: vop: Default enable win2/3 area0 bit
  drm/rockchip: vop: restore vop registers when resume
  drm/rockchip: vop: support plane scale


-- 
1.7.9.5
