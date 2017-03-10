From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sat, 11 Mar 2017 03:33:51 +0800
Subject: [PATCH v2 05/11] Documentation: DT: bindings: mfd: add A33 GPADC
 binding
In-Reply-To: <20170310122544.wkbqnzq2twfciyaw@lukather>
References: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
 <20170310103921.19469-6-quentin.schulz@free-electrons.com>
 <20170310122544.wkbqnzq2twfciyaw@lukather>
Message-ID: <5847351489174431@web4o.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



10.03.2017, 20:26, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> On Fri, Mar 10, 2017 at 11:39:15AM +0100, Quentin Schulz wrote:
>> ?This patch adds documentation for the A33 GPADC binding.
>>
>> ?Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ?---
>>
>> ?added in v2
>>
>> ??.../devicetree/bindings/mfd/sun4i-gpadc.txt | 59 ++++++++++++++++++++++
>> ??1 file changed, 59 insertions(+)
>> ??create mode 100644 Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>>
>> ?diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>> ?new file mode 100644
>> ?index 0000000..17242c8
>> ?--- /dev/null
>> ?+++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>> ?@@ -0,0 +1,59 @@
>> ?+Allwinner SoCs' GPADC Device Tree bindings
>> ?+------------------------------------------
>> ?+The Allwinner SoCs all have an ADC that can also act as a thermal sensor
>> ?+and sometimes as a touchscreen controller.
>> ?+
>> ?+Required properties:
>> ?+ - compatible: "sun8i-a33-gpadc-iio",
>
> This doesn't match your example, and you shouldn't have IIO in
> there. Compatibles shouldn't be tied to a given framework, since that
> is Linux specific (and might even change in the future).

>From this aspect, I think we shouldn't even call it gpadc in compatible --
as it's not GP at all on A33.

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
> ,
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
