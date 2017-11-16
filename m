From: hjc@rock-chips.com (Sandy Huang)
Date: Thu, 16 Nov 2017 17:47:11 +0800
Subject: [PATCH 0/2] add support rk3126 vop support
In-Reply-To: <1510658851-90160-1-git-send-email-hjc@rock-chips.com>
References: <1510658851-90160-1-git-send-email-hjc@rock-chips.com>
Message-ID: <abe45b77-5df6-8f17-a4fc-33b967689708@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pushed to drm-misc-next.

? 2017/11/14 19:27, Sandy Huang ??:
> The following patch add support RK3126 vop support, there is only one
> VOP at RK3126, and the RK3126 VOP register layout is similar with RK3036,
> so some feature can reuse with RK3036.
> 
> Sandy Huang (2):
>    dt-bindings: add document for rk3126-vop
>    drm/rockchip: vop: add rk3126 vop support
> 
>   .../bindings/display/rockchip/rockchip-vop.txt     |  1 +
>   drivers/gpu/drm/rockchip/rockchip_vop_reg.c        | 30 ++++++++++++++++++++++
>   drivers/gpu/drm/rockchip/rockchip_vop_reg.h        |  6 +++++
>   3 files changed, 37 insertions(+)
> 
