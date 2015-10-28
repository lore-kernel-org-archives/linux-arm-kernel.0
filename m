From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 28 Oct 2015 22:13:42 +0900
Subject: [PATCH] MAINTAINERS: Start using the 'reviewer' (R) tag
In-Reply-To: <20151028095524.GP5828@x1>
References: <1445960557-24328-1-git-send-email-lee.jones@linaro.org>
 <20151027172428.GB21070@earth> <20151027181555.GE5828@x1>
 <1445971482.2757.27.camel@perches.com>
 <CAJKOXPc_w2Dc8LvkCu_d+kjZZmYScXboQrpNWdicT2yfL_5D7Q@mail.gmail.com>
 <20151028082446.GF5828@x1> <56309419.4060908@samsung.com>
 <20151028093907.GP4931@pengutronix.de> <20151028095524.GP5828@x1>
Message-ID: <5630CA06.7050503@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 28.10.2015 o 18:55, Lee Jones pisze:
> On Wed, 28 Oct 2015, Uwe Kleine-K?nig wrote:
> 
>> Hello,
>>
>> On Wed, Oct 28, 2015 at 06:23:37PM +0900, Krzysztof Kozlowski wrote:
>>> On 28.10.2015 17:24, Lee Jones wrote:
>>>> You guys are pushing back like this is some kind of demotion.
>>>> That's not the case at all.  All it does is better describe the (very
>>>> worthy) function you *actually* provide.
>>>
>>> It is getting into dispute about entire change of yours... which is not
>>> what I want. I agree with your general idea but I was referring only to
>>> that particular case - the Samsung PMICs (and Maxim PMICs/MUICs which
>>> would fall into same category).
>>
>> Not being affected by this change, I wonder what the technical
>> difference is if someone is listed as reviewer instead of maintainer.
>> Does get_maintainer.pl behave differently?
> 
> Reviewers are people who should be Cc'ed on all patches, as are
> Maintainers, so no, fundamentally they are treated the same by a
> Submitter.
> 
> Here is some output for Maintainers/Reviews from get_maintainer.pl.
> 
>  $ ./scripts/get_maintainer.pl -f arch/arm/boot/dts/vf500.dtsi
>  Shawn Guo <shawnguo@kernel.org> (maintainer:ARM/FREESCALE VYBRID ARM ARCHITECTURE)
>  Sascha Hauer <kernel@pengutronix.de> (maintainer:ARM/FREESCALE VYBRID ARM ARCHITECTURE)
>  Stefan Agner <stefan@agner.ch> (reviewer)
>  Russell King <linux@arm.linux.org.uk> (maintainer:ARM PORT)
>  linux-arm-kernel at lists.infradead.org (moderated list:ARM/FREESCALE VYBRID ARM ARCHITECTURE)
>  devicetree at vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
>  linux-kernel at vger.kernel.org (open list)
> 
> I'm sure we can make the output even more similar by listing the
> MAINTAINERS tag after "reviewer" too.

And here is the output of drivers/mfd/sec-core.c *before*:
Sangbeom Kim <sbkim73@samsung.com> (supporter:SAMSUNG MULTIFUNCTION PMIC DEVICE DRIVERS)
Krzysztof Kozlowski <k.kozlowski@samsung.com> (supporter:SAMSUNG MULTIFUNCTION PMIC DEVICE DRIVERS)
Lee Jones <lee.jones@linaro.org> (supporter:MULTIFUNCTION DEVICES (MFD))


and after (where I am listed as reviewer):
Sangbeom Kim <sbkim73@samsung.com> (reviewer)
Krzysztof Kozlowski <k.kozlowski@samsung.com> (reviewer)
Lee Jones <lee.jones@linaro.org> (supporter:MULTIFUNCTION DEVICES (MFD))

Maybe it should be "supporter reviewer"?

Best regards,
Krzysztof
