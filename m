From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 23 May 2016 14:10:16 +0800
Subject: [PATCH 0/3] drm/rockchip: fix some sparse warnings
In-Reply-To: <20160510160356.1167-1-john@metanate.com>
References: <20160510160356.1167-1-john@metanate.com>
Message-ID: <57429EC8.4080207@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?05?11? 00:03, John Keeping wrote:
> The first patch wasn't found by sparse, but is something I noticed while
> in the area.  The following two fix all of the sparse warnings inside
> drm/rockchip.
>
> John Keeping (3):
>    drm/rockchip: dw_hdmi: remove unused #include
>    drm/rockchip: fb: add missing header
>    drm/rockchip: fix "should it be static?" warnings
>
>   drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 1 -
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 4 ++--
>   drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 7 ++++---
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++--
>   drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 2 +-
>   5 files changed, 9 insertions(+), 9 deletions(-)
>

Hi John

Sorry for reply late, this series of patches looks good for me, Applied 
to my branch.

Thanks.

-- 
?ark Yao
