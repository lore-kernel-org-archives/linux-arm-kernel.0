From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 12 Jan 2017 03:39:53 +0800
Subject: [PATCH 2/5] clk: sunxi-ng: add support for V3s CCU
In-Reply-To: <20170110181006.yrd6moy2mctzoc4c@lukather>
References: <20170103151629.19447-1-icenowy@aosc.xyz>
 <20170103151629.19447-3-icenowy@aosc.xyz>
 <20170110181006.yrd6moy2mctzoc4c@lukather>
Message-ID: <2705031484163593@web1g.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



11.01.2017, 02:10, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> On Tue, Jan 03, 2017 at 11:16:26PM +0800, Icenowy Zheng wrote:
>> ?V3s has a similar but cut-down CCU to H3.
>>
>> ?Add support for it.
>>
>> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>
> It looks like there's nothing different but the clocks that you
> register with the H3, please just use the H3 driver.

Nope.

It has a different PLL (PLL_ISP) at different address, and some
different muxes.

>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
