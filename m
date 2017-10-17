From: seanpaul@chromium.org (Sean Paul)
Date: Tue, 17 Oct 2017 11:43:31 -0400
Subject: [PATCH v3 4/4] drm/rockchip: vop: Add more RGB output interface
 type
In-Reply-To: <1507536424-110871-1-git-send-email-hjc@rock-chips.com>
References: <1507536396-106827-1-git-send-email-hjc@rock-chips.com>
 <1507536424-110871-1-git-send-email-hjc@rock-chips.com>
Message-ID: <20171017154331.ti2pnl4gmclbrfmu@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 09, 2017 at 04:07:04PM +0800, Sandy Huang wrote:
> This patch add serial RGB output interface for rockchip vop, the
> more info about serial RGB output interface described at the
> following file:
> 
> Documentation/devicetree/bindings/display/panel/panel-rgb.txt
> 
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
> ---
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> index 56bbd2e..59a01c3 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> @@ -209,6 +209,8 @@ struct vop_data {
>  #define ROCKCHIP_OUT_MODE_P888	0
>  #define ROCKCHIP_OUT_MODE_P666	1
>  #define ROCKCHIP_OUT_MODE_P565	2
> +#define ROCKCHIP_OUT_MODE_S888	8
> +#define ROCKCHIP_OUT_MODE_S888_DUMMY	12
>  /* for use special outface */
>  #define ROCKCHIP_OUT_MODE_AAAA	15
>  
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
