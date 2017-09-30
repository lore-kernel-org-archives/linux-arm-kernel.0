From: hjc@rock-chips.com (Sandy Huang)
Date: Sat, 30 Sep 2017 16:25:06 +0800
Subject: [PATCH v2 0/3] Add support rockchip RGB output interface
In-Reply-To: <1506049221-117283-1-git-send-email-hjc@rock-chips.com>
References: <1506049221-117283-1-git-send-email-hjc@rock-chips.com>
Message-ID: <b66bc75d-b217-a54f-272a-b5ee7d0b57d3@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do you  have any suggests for this series of patches?
Or apply to drm-misc-next?

? 2017/9/22 11:00, Sandy Huang ??:
> This patches add support rockchip RGB output, Some Rockchip CRTCs, like rv1108,
> can directly output parallel and serial RGB data to panel or to conversion chip.
> So we add this driver to probe encoder and connector to support this case.
> 
> Sandy Huang (3):
>    dt-bindings: Add document for rockchip RGB output interface
>    drm/rockchip: Add support for Rockchip Soc RGB output interface
>    drm/rockchip: vop: Add more RGB output interface type
> 
>   .../bindings/display/rockchip/rockchip-rgb.txt     |  78 +++++
>   drivers/gpu/drm/rockchip/Kconfig                   |   9 +
>   drivers/gpu/drm/rockchip/Makefile                  |   1 +
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   2 +
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |   1 +
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |   2 +
>   drivers/gpu/drm/rockchip/rockchip_rgb.c            | 343 +++++++++++++++++++++
>   7 files changed, 436 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
>   create mode 100644 drivers/gpu/drm/rockchip/rockchip_rgb.c
> 
