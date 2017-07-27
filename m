From: jeffy.chen@rock-chips.com (jeffy)
Date: Thu, 27 Jul 2017 16:59:45 +0800
Subject: [v6,5/7] drm/rockchip: vop: add a series of vop support
In-Reply-To: <1501049971-6131-1-git-send-email-mark.yao@rock-chips.com>
References: <1501049971-6131-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <5979AB81.4040503@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi mark,

On 07/26/2017 02:19 PM, Mark yao wrote:
> Vop Full framework now has following vops:
> IP version    chipname
>    3.1           rk3288
>    3.2           rk3368
>    3.4           rk3366
>    3.5           rk3399 big
>    3.6           rk3399 lit
>    3.7           rk3228
>    3.8           rk3328
>
> The above IP version is from H/W define, some of vop support get
> the IP version from VERSION_INFO register, some are not.
> hardcode the IP version for each vop to identify them.
>
> major version: used for IP structure, Vop full framework is 3,
>                 vop little framework is 2.
> minor version: on same structure, newer design vop will bigger
>                 then old one.
>
> Signed-off-by: Mark Yao<mark.yao@rock-chips.com>

Reviewed-by: Jeffy Chen <jeffy.chen@rock-chips.com>
