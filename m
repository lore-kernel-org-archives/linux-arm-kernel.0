From: mark.yao@rock-chips.com (Mark yao)
Date: Wed, 26 Aug 2015 14:34:21 +0800
Subject: [GIT PULL] drm/rockchip: fixes and new features
In-Reply-To: <1437962762-19157-1-git-send-email-mark.yao@rock-chips.com>
References: <1437962762-19157-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <55DD5DED.7030109@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave
     Here are some fixes and some new features for rockchip drm,
     tested on popmetal rk3288 board, can you land them?

The following changes since commit db56176025cee5e242dfeed5f4e304d095d29fa3:

   Revert "drm/atomic: Call ww_acquire_done after check phase is 
complete" (2015-08-25 17:23:36 +1000)

are available in the git repository at:

   https://github.com/markyzq/kernel-drm-rockchip.git 
drm-rockchip-2015-08-26

for you to fetch changes up to 4c156c21c7948a0be854cbe5914af3181303e529:

   drm/rockchip: vop: support plane scale (2015-08-26 14:16:26 +0800)

----------------------------------------------------------------
Mark Yao (6):
       drm/rockchip: vop: Fix virtual stride calculation
       drm/rockchip: vop: Fix window dest start point
       drm/rockchip: vop: Add yuv plane support
       drm/rockchip: vop: Default enable win2/3 area0 bit
       drm/rockchip: vop: restore vop registers when resume
       drm/rockchip: vop: support plane scale

  drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  269 
++++++++++++++++++++++++++-
  drivers/gpu/drm/rockchip/rockchip_drm_vop.h |   88 +++++++++
  2 files changed, 348 insertions(+), 9 deletions(-)

-Mark
