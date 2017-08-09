From: architt@codeaurora.org (Archit Taneja)
Date: Wed, 9 Aug 2017 16:02:45 +0530
Subject: [PATCH 0/3] drm: make drm_connector_funcs structures const
In-Reply-To: <1502191712-11231-1-git-send-email-bhumirks@gmail.com>
References: <1502191712-11231-1-git-send-email-bhumirks@gmail.com>
Message-ID: <3bb03b50-5b73-4fee-2323-d3b67ed3553e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/08/2017 04:58 PM, Bhumika Goyal wrote:
> Declare drm_connector_funcs structures as const.

Could you rebase this series over the latest drm-misc-next? The
recently merged patch "drm: Nuke drm_atomic_helper_connector_dpms"
causes conflicts with these.

drm-misc-next:

https://cgit.freedesktop.org/drm/drm-misc/log/

Thanks,
Archit

> 
> Bhumika Goyal (3):
>    drm/bridge: make drm_connector_funcs structures const
>    drm/sun4i: make drm_connector_funcs structures const
>    drm/rockchip: make drm_connector_funcs structures const
> 
>   drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 2 +-
>   drivers/gpu/drm/rockchip/inno_hdmi.c         | 2 +-
>   drivers/gpu/drm/sun4i/sun4i_rgb.c            | 2 +-
>   drivers/gpu/drm/sun4i/sun4i_tv.c             | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
