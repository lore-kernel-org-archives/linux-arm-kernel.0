From: sandy.huang@rock-chips.com (Sandy Huang)
Date: Thu, 3 Aug 2017 20:36:49 +0800
Subject: [PATCH 1/6] drm/rockchip: vop: no need wait vblank on crtc enable
In-Reply-To: <1501494577-6884-1-git-send-email-mark.yao@rock-chips.com>
References: <1501494569-6825-1-git-send-email-mark.yao@rock-chips.com>
 <1501494577-6884-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <69cdfbce-d6ab-56d9-2514-243cfa7e42ee@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi mark,

? 2017/7/31 17:49, Mark Yao ??:
> Since atomic framework, crtc enable and disable are in pairs,
> no need to wait vblank.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 36 -----------------------------
>   1 file changed, 36 deletions(-)
> 

Reviewed-by: Sandy huang <sandy.huang@rock-chips.com>
