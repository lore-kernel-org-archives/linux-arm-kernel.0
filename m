From: seanpaul@chromium.org (Sean Paul)
Date: Mon, 13 Mar 2017 16:08:40 -0400
Subject: [PATCH 0/3] RK3399 cdd-dp patches
In-Reply-To: <1488940077-22297-1-git-send-email-zyw@rock-chips.com>
References: <1488940077-22297-1-git-send-email-zyw@rock-chips.com>
Message-ID: <20170313200840.GX20329@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 10:27:54AM +0800, Chris Zhong wrote:
> Hi all
> This series is to correct some mistakes in clk_get_rate and the register
> address. And in order to better develop, adding more prints.
> 
> 
> Chris Zhong (3):
>   drm/rockchip: cdn-dp: return error code when clk_get_rate failed
>   drm/rockchip: cdn-dp: Correct PHY register address
>   drm/rockchip: cdn-dp: add more log for video config

Hi Chris,
Thanks for sending these up, I've applied the entire series to drm-misc

Sean

> 
>  drivers/gpu/drm/rockchip/cdn-dp-core.c |  5 +++--
>  drivers/gpu/drm/rockchip/cdn-dp-reg.c  |  6 +++++-
>  drivers/gpu/drm/rockchip/cdn-dp-reg.h  | 13 ++++++-------
>  3 files changed, 14 insertions(+), 10 deletions(-)
> 
> -- 
> 2.6.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
