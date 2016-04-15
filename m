From: david.wu@rock-chips.com (David.Wu)
Date: Fri, 15 Apr 2016 20:12:03 +0800
Subject: [PATCH v5 2/2] i2c: rk3x: add i2c support for rk3399 soc
In-Reply-To: <2530516.Iqqf6HUmr5@diego>
References: <1458147438-62387-1-git-send-email-david.wu@rock-chips.com>
 <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
 <20160414184848.GB2338@katana> <2530516.Iqqf6HUmr5@diego>
Message-ID: <5710DA93.1020708@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

? 2016/4/15 15:31, Heiko St?bner ??:
> David,
>
> Am Donnerstag, 14. April 2016, 20:48:48 schrieb Wolfram Sang:
>>> + - input-clk-rate : frequency rate of function clock used(in Hz). If
>>> omitted, +	the default clock rate is used. It is just used at rk3399 soc.
>> Why is this needed? Why don't we simply use the default or calculate the
>> best value somehow?
> if you need to _get_ the clock-rate, clk_get_rate is the abvious choice and if
> you need to _set_ some specific rate, I guess it should be done via the
> assigned-clocks mechanism in the devicetree - see veyron dts files that already
> do this for some other parts.

Okay, i will try it, thank you.

>
>
>
>
