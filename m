From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed, 14 Dec 2016 04:54:14 +0800
Subject: [PATCH 2/6] clk: sunxi-ng: set the parent rate when adjustin CPUX
 clock on A33
In-Reply-To: <20161213154451.y4wcrqhtcc5sqli7@lukather>
References: <20161213152252.53749-1-icenowy@aosc.xyz>
 <20161213152252.53749-3-icenowy@aosc.xyz>
 <20161213154451.y4wcrqhtcc5sqli7@lukather>
Message-ID: <306991481662454@web33j.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



13.12.2016, 23:44, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> On Tue, Dec 13, 2016 at 11:22:48PM +0800, Icenowy Zheng wrote:
>> ?The CPUX clock on A33, which is for the Cortex-A7 cores, is designed to
>> ?be changeable by changing the rate of PLL_CPUX.
>>
>> ?Add CLK_SET_RATE_PARENT flag to this clock.
>>
>> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Excuse me, have you merged this patch?

If merged, I won't contain it in my PATCH v2, thus the PATCH v2 will contain
only an updated OPP patch.

>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
