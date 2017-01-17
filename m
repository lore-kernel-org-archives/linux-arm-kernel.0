From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed, 18 Jan 2017 00:52:57 +0800
Subject: [PATCH v2 1/4] arm: sunxi: add support for V3s SoC
In-Reply-To: <20170117090549.uqwsiwmclzhx7456@lukather>
References: <20170116180116.36729-2-icenowy@aosc.xyz>
 <20170117090549.uqwsiwmclzhx7456@lukather>
Message-ID: <3856551484671977@web20j.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



17.01.2017, 17:06, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> On Tue, Jan 17, 2017 at 02:01:13AM +0800, Icenowy Zheng wrote:
>> ?Allwinner V3s is a low-end single-core Cortex-A7 SoC, with 64MB
>> ?integrated DRAM, and several peripherals.
>>
>> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> ?---
>> ?Changes in v2:
>> ?- Used linux-sunxi.org wiki hosted address of V3s datasheet.
>>
>> ?Note: the V3s datasheet contains its user manual.
>
> That would be great to use User Manual in the filename rather than
> datasheet then. The datasheet is something different.

Allwinner named it datasheet.

For previous SoCs, datasheet will contain info about pins, and user manual
about registers.

But for H3 and V3s, datasheet now contains both pins' info and registers' info.

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
