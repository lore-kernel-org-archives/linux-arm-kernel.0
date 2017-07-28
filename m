From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 28 Jul 2017 14:48:36 +0200
Subject: [PATCH v6 5/7] drm/rockchip: vop: add a series of vop support
In-Reply-To: <1501049971-6131-1-git-send-email-mark.yao@rock-chips.com>
References: <1501049930-5794-1-git-send-email-mark.yao@rock-chips.com>
 <1501049971-6131-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <3368237.z7l18g54BE@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 26. Juli 2017, 14:19:30 CEST schrieb Mark Yao:
> Vop Full framework now has following vops:
> IP version    chipname
>   3.1           rk3288
>   3.2           rk3368
>   3.4           rk3366
>   3.5           rk3399 big
>   3.6           rk3399 lit
>   3.7           rk3228
>   3.8           rk3328
> 
> The above IP version is from H/W define, some of vop support get
> the IP version from VERSION_INFO register, some are not.
> hardcode the IP version for each vop to identify them.
> 
> major version: used for IP structure, Vop full framework is 3,
>                vop little framework is 2.
> minor version: on same structure, newer design vop will bigger
>                then old one.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>

on rk3036 and rk3288
Tested-by: Heiko Stuebner <heiko@sntech.de>


Heiko
