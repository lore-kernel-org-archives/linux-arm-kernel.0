From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 28 Dec 2015 09:36:32 +0800
Subject: [GIT PULL] drm/rockchip: new features
Message-ID: <56809220.8090905@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave

These patches convert drm/rockchip to atomic API and add rk3036 vop support.

drm/rockchip: covert to support atomic API:
     https://lkml.org/lkml/2015/12/16/824

add rk3036 vop support:
     https://lkml.org/lkml/2015/12/16/851

These patch tested on popmetal board(rk3288) and kylin board(rk3036).

Now seems there is no doubt on these patches, and rk3036 dt-bindings got 
Acked-by from Rob Herring.

So I'd like you can land these patches.

Thanks.


The following changes since commit 20f8e032e6dc7053ab803f488e2a8839cd2f69a6:

   Backmerge drm-fixes merge into Linus's tree into drm-next. 
(2015-12-24 08:08:47 +1000)

are available in the git repository at:


   https://github.com/markyzq/kernel-drm-rockchip.git 
drm-rockchip-next-2015-12-28

for you to fetch changes up to d4d3c6cbc289d78a9f5b54378beb338eb35d927e:

   dt-bindings: add document for rk3036-vop (2015-12-28 09:08:53 +0800)

----------------------------------------------------------------
Mark Yao (14):
       drm/rockchip: Use new vblank api drm_crtc_vblank_*
       drm/rockchip: vop: replace dpms with enable/disable
       drm/rockchip: Convert to support atomic API
       drm/rockchip: Optimization vop mode set
       drm/rockchip: support atomic asynchronous commit
       drm/rockchip: direct config connecter gate and out_mode
       drm: bridge/dw_hdmi: add atomic API support
       drm/rockchip: dw_hdmi: use encoder enable function
       drm/rockchip: vop: merge vop cfg_done into vop_data
       drm/rockchip: vop: move interrupt registers into vop_data
       drm/rockchip: vop: spilt register related into rockchip_reg_vop.c
       drm/rockchip: vop: spilt scale regsters
       drm/rockchip: vop: add rk3036 vop support
       dt-bindings: add document for rk3036-vop

-- 
?ark Yao
