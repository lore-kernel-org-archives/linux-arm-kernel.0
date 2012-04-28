From: shijie8@gmail.com (Huang Shijie)
Date: Sat, 28 Apr 2012 09:31:55 -0400
Subject: [PATCH v2 0/3] add gpmi-nand dt support for mx6q and mx28
In-Reply-To: <1335614459.1937.13.camel@koala>
References: <1335323184-11233-1-git-send-email-b32955@freescale.com>
 <1335614459.1937.13.camel@koala>
Message-ID: <CAMiH66GgMFVp4+4+6PVp-+CPqdFykO1BeE_2EHC2YmWYZ917yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Artem:

On Sat, Apr 28, 2012 at 8:00 AM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Wed, 2012-04-25 at 11:06 +0800, Huang Shijie wrote:
>> The mx6q-arm2 and imx28evk have already support the device tree now.
>> So i decide to add the gpmi-nand dt support to them.
>>
>> The mx23 does not support the device tree now. I will add the gpmi dt support
>> when it is ready.
>
> I cannot apply these patches to l2-mtd.git:
Could you only apply the gpmi-nand patch? The other two patches are
for DT, and should be appled in Shawn's tree.

Best Regards
Huang Shijie






>
> Applying: ARM: mx28: add gpmi-nand dt support
> error: arch/arm/boot/dts/imx28-evk.dts: does not exist in index
> error: arch/arm/boot/dts/imx28.dtsi: does not exist in index
>
> --
> Best Regards,
> Artem Bityutskiy
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
