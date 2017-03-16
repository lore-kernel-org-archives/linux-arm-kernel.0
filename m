From: jeffy.chen@rock-chips.com (jeffy)
Date: Thu, 16 Mar 2017 10:07:20 +0800
Subject: [PATCH v3] drm/rockchip: Refactor the component match logic.
In-Reply-To: <19101003.9xjQ92OS5C@phil>
References: <1489573247-9628-1-git-send-email-jeffy.chen@rock-chips.com>
 <19101003.9xjQ92OS5C@phil>
Message-ID: <58C9F358.4020805@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 03/16/2017 01:00 AM, Heiko Stuebner wrote:
> Am Mittwoch, 15. M?rz 2017, 18:20:47 CET schrieb Jeffy Chen:
>> Currently we are adding all components from the dts, if one of their
>> drivers been disabled, we would not be able to bring up others.
>>
>> Refactor component match logic, follow exynos drm.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>
> This reliably produces null pointer dereference errors in
> 	__platform_driver_register called from rockchip_drm_init
> on at least rk3036 and rk3288 (probably more) when applied on top of
> Linus' tree from today. Log attached and Rockchip drm compiled as module.
>
> I'm currently dug into other areas, so hadn't have time to investigate further
> yet.
>
>
> Heiko
>
oops, sorry, i'll upload a new version to fix that, thanx.
