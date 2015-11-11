From: mark.yao@rock-chips.com (Mark yao)
Date: Wed, 11 Nov 2015 08:56:51 +0800
Subject: [GIT PULL] drm/rockchip: fixes
Message-ID: <56429253.6050107@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave
      Here are some fixes for drm/rockchip:
         drm/rockchip can't work now, we need the patch
                 Revert "drm/rockchip: Convert the probe function to the 
generic drm_of_component_probe()"
         and other three fixes are also needed.

      I'd like you can land them.

The following changes since commit 
816d2206f0f9953ca854e4ff1a2749a5cbd62715:

   Merge tag 'drm-intel-next-fixes-2015-11-06' of 
git://anongit.freedesktop.org/drm-intel into drm-next (2015-11-07 
17:16:59 +1000)

are available in the git repository at:


https://github.com/markyzq/kernel-drm-rockchip.git drm-rockchip-2015-11-11

for you to fetch changes up to 55ac58b5d27a35b8caaa9bd07eb1d2899473130c:

   drm/rockchip: vop: fix window origin calculation (2015-11-11 08:36:18 
+0800)

----------------------------------------------------------------
Dominik Behr (1):
       drm/rockchip: vop: fix window origin calculation

Heiko Stuebner (1):
       drm/rockchip: unset pgoff when mmap'ing gems

Mark Yao (1):
       Revert "drm/rockchip: Convert the probe function to the generic 
drm_of_component_probe()"

Sjoerd Simons (1):
       drm/rockchip: vop: Correct enabled clocks during setup

  drivers/gpu/drm/rockchip/rockchip_drm_drv.c |   81 
+++++++++++++++++++++++++--
  drivers/gpu/drm/rockchip/rockchip_drm_gem.c |    1 +
  drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   40 ++++++-------
  3 files changed, 92 insertions(+), 30 deletions(-)

-- 
?ark Yao
