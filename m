From: mark.yao@rock-chips.com (Mark yao)
Date: Wed, 06 Jan 2016 16:24:44 +0800
Subject: [GIT PULL] drm/rockchip: new features to support Synopsys DW MIPI DSI
Message-ID: <568CCF4C.3070003@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave

Now seems there is no doubt on these patches, Documentation is Acked-by 
Rob Herring, and it looks good for me.

So I'd like you can land them.

The following changes since commit c11b8989635166c5a1e6aac1853a847bd664f8db:

   Merge tag 'omapdrm-4.5-resolved' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux into drm-next 
(2016-01-01 07:41:52 +1000)

are available in the git repository at:


   https://github.com/markyzq/kernel-drm-rockchip.git 
drm-rockchip-next-2016-01-06

for you to fetch changes up to 84e05408fcfefb9b28050f701e1e94fe9f86804b:

   drm: rockchip: Support Synopsys DW MIPI DSI (2016-01-06 16:16:39 +0800)

----------------------------------------------------------------
Chris Zhong (3):
       drm/rockchip: return a true clock rate to adjusted_mode
       Documentation: dt-bindings: Add bindings for rk3288 DW MIPI DSI 
driver
       drm: rockchip: Support Synopsys DW MIPI DSI

  .../display/rockchip/dw_mipi_dsi_rockchip.txt      |   60 +
  drivers/gpu/drm/rockchip/Kconfig                   |   10 +
  drivers/gpu/drm/rockchip/Makefile                  |    1 +
  drivers/gpu/drm/rockchip/dw-mipi-dsi.c             | 1194 
++++++++++++++++++++
  drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |    8 +
  5 files changed, 1273 insertions(+)
  create mode 100644 
Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
  create mode 100644 drivers/gpu/drm/rockchip/dw-mipi-dsi.c

-- 
?ark Yao
