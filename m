From: zhengxing@rock-chips.com (Xing Zheng)
Date: Mon, 28 Sep 2015 20:53:03 +0800
Subject: [PATCH v2 7/9] rockchip: make sure timer5 is enabled on rk3036
 platforms
In-Reply-To: <1726823.4nE2gJuWPe@diego>
References: <1442478540-15068-1-git-send-email-zhengxing@rock-chips.com>
 <11125723.j2J5LpAGi4@diego> <560931A3.2020403@rock-chips.com>
 <1726823.4nE2gJuWPe@diego>
Message-ID: <5609382F.2000203@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?09?28? 20:44, Heiko St?bner wrote:
> Hi,
>
> Am Montag, 28. September 2015, 20:25:07 schrieb Xing Zheng:
>> On 2015?09?17? 23:05, Heiko St?bner wrote:
>>> Am Donnerstag, 17. September 2015, 18:37:24 schrieb Xing Zheng:
>>>> The timer5 supplies the architected timer and thus as has to run when
>>>> the system clocksource and clockevents drivers are registered.
>>> please kindly ask the people doing uboot development to do this in uboot
>>> itself in future socs :-) - for example Simon's rk3288 mainline uboot does
>>> this correctly.
>> OK, I will ask the engineer who is doing uboot whether needs to add
>> this patch. So I will remove it from the patchset v3 of "Build and support
>> rk3036 SoC platform".
> No, I really only meant try to make people get this right in the future :-).
>
> For the rk3036 there are probably already devices on the market with uboots
> sporting that issue. So it's ok to have this in here now, it's just to make
> sure it gets really fixed in future socs.
>
>
> Heiko
>
>
OK, I got it.

Thank you. :)
