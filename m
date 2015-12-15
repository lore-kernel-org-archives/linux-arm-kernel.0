From: sasukewxt@163.com (Caesar Wang)
Date: Tue, 15 Dec 2015 08:48:08 +0800
Subject: [PATCH 1/2] ARM: dts: modify rk3288 jaq backlight-level
In-Reply-To: <1868289.Tn7cSBTFBY@diego>
References: <1449493869-32151-1-git-send-email-wxt@rock-chips.com>
 <1868289.Tn7cSBTFBY@diego>
Message-ID: <566F6348.2070405@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,


? 2015?12?15? 05:46, Heiko St?bner ??:
> Hi Caesar,
>
> Am Montag, 7. Dezember 2015, 21:11:08 schrieb Caesar Wang:
>> the panel which jaq use require the pwm duty cycle larger than 3%,
>> when the backlight status from power off to power on, otherwise the
>> backlight will flush, so we modify the second brightness-level to 8,
>> and when the backlight from power off to power on the pwm duty cycle
>> will larger than 3%.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> I've merged the two patches and included them in my series for the veyron edp
> devicetree changes [0].
>
>
> Heiko
>
> [0] https://github.com/mmind/linux-rockchip/commit/45e3abed0a86c7ee5cea0b35492b65890b928175

Yep, that's more resonable since we need depend on this edp device node.

https://github.com/rockchip-linux/kernel/commit/6d1491faf1e5eee98dfcd9bb1ba1b7f866cd51ab

>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
