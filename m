From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 21 Nov 2015 22:50:10 +0100
Subject: [GIT PULL] drm/rockchip: fixes
In-Reply-To: <56429253.6050107@rock-chips.com>
References: <56429253.6050107@rock-chips.com>
Message-ID: <3016892.vBtLqFySEY@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,
Am Mittwoch, 11. November 2015, 08:56:51 schrieb Mark yao:
>       Here are some fixes for drm/rockchip:
>          drm/rockchip can't work now, we need the patch
>                  Revert "drm/rockchip: Convert the probe function to the 
> generic drm_of_component_probe()"
>          and other three fixes are also needed.
> 
>       I'd like you can land them.
> 
> The following changes since commit 
> 816d2206f0f9953ca854e4ff1a2749a5cbd62715:
> 
>    Merge tag 'drm-intel-next-fixes-2015-11-06' of 
> git://anongit.freedesktop.org/drm-intel into drm-next (2015-11-07 
> 17:16:59 +1000)
> 
> are available in the git repository at:
> 
> 
> https://github.com/markyzq/kernel-drm-rockchip.git drm-rockchip-2015-11-11
> 
> for you to fetch changes up to 55ac58b5d27a35b8caaa9bd07eb1d2899473130c:
> 
>    drm/rockchip: vop: fix window origin calculation (2015-11-11 08:36:18 
> +0800)
> 
> ----------------------------------------------------------------
> Dominik Behr (1):
>        drm/rockchip: vop: fix window origin calculation
> 
> Heiko Stuebner (1):
>        drm/rockchip: unset pgoff when mmap'ing gems
> 
> Mark Yao (1):
>        Revert "drm/rockchip: Convert the probe function to the generic 
> drm_of_component_probe()"

Dave already applied this patch by himself, back before -rc1 was released,
so I guess you should re-do you branch (and pull request) based on
either 4.4-rc1 or Dave's drm-fixes branch.


Heiko
