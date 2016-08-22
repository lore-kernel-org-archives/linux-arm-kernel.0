From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Mon, 22 Aug 2016 16:47:51 +0800
Subject: [PATCH v3 1/2] Documentation: dt: Add new compatible to sunxi mmc
 driver bindings
In-Reply-To: <20160822075847.GD7104@lukather>
References: <20160801151351.51854-1-icenowy@aosc.xyz>
 <20160801151351.51854-2-icenowy@aosc.xyz> <20160822075847.GD7104@lukather>
Message-ID: <370671471855671@web30j.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



22.08.2016, 15:58, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> Hi Icenowy,
>
> On Mon, Aug 01, 2016 at 11:13:50PM +0800, Icenowy Zheng wrote:
>> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> ?---
>> ?Changes in v2:
>> ?- Rebased on Hans de Goede's patchset.
>>
>> ??Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 1 +
>> ??1 file changed, 1 insertion(+)
>>
>> ?diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
>> ?index 904ff9f..55cdd80 100644
>> ?--- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
>> ?+++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
>> ?@@ -13,6 +13,7 @@ Required properties:
>> ?????* "allwinner,sun5i-a13-mmc"
>> ?????* "allwinner,sun7i-a20-mmc"
>> ?????* "allwinner,sun9i-a80-mmc"
>> ?+ * "allwinner,sun50i-a64-mmc"
>> ???- reg : mmc controller base registers
>> ???- clocks : a list with 4 phandle + clock specifier pairs
>> ???- clock-names : must contain "ahb", "mmc", "output" and "sample"
>
> You need to document that the output and sample clocks are not
> mandatory in the A64 case.

Oh, sorry.

This series of patch is dropped now...

At least I and Andre have no SD Card suitable for DDR mode...

Maybe the patches can only be tested on eMMC.

However, at least on Pine64, our SD Cards are working steaily.

>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
