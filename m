From: bcousson@baylibre.com (Benoit Cousson)
Date: Wed, 14 Aug 2013 09:43:59 +0200
Subject: [PATCH 12/22] ARM: dts: Remove '0x's from OMAP2420 H4 DTS file
In-Reply-To: <20130814073000.GW7656@atomide.com>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-12-git-send-email-lee.jones@linaro.org>
 <20130813154425.GH15278@lee--X1> <20130814073000.GW7656@atomide.com>
Message-ID: <520B353F.40106@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

Thanks for that cleanup.

On 14/08/2013 09:30, Tony Lindgren wrote:
> * Lee Jones <lee.jones@linaro.org> [130813 08:51]:
>> Tony, Benoit,
>>
>> Poke
>
> Looks like Benoit's new email address is bcousson at baylibre.com.
> Probably best for Benoit to pick these to avoid merge conflicts.

I've just applied the 7 following patches. Let me know if I missed 
something.

6b9fa1b ARM: dts: Remove '0x's from OMAP5 DTS file
79390b8 ARM: dts: Remove '0x's from OMAP4 DTS file
dd60fef ARM: dts: Remove '0x's from OMAP3430 SDP DTS file
bfef1cb ARM: dts: Remove '0x's from OMAP3 DTS file
5f547ac ARM: dts: Remove '0x's from OMAP3 IGEP0030 DTS file
27939fc ARM: dts: Remove '0x's from OMAP3 IGEP0020 DTS file
62eb4d1 ARM: dts: Remove '0x's from OMAP2420 H4 DTS file

Regards,
Benoit

>
> Regards,
>
> Tony
>
>> On Mon, 22 Jul 2013, Lee Jones wrote:
>>
>>> Cc: Beno?t Cousson <b-cousson@ti.com>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Cc: linux-omap at vger.kernel.org
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>> ---
>>>   arch/arm/boot/dts/omap2420-h4.dts | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/omap2420-h4.dts
>>> index 224c08f..34cdecb 100644
>>> --- a/arch/arm/boot/dts/omap2420-h4.dts
>>> +++ b/arch/arm/boot/dts/omap2420-h4.dts
>>> @@ -50,15 +50,15 @@
>>>   			label = "bootloader";
>>>   			reg = <0 0x20000>;
>>>   		};
>>> -		partition at 0x20000 {
>>> +		partition at 20000 {
>>>   			label = "params";
>>>   			reg = <0x20000 0x20000>;
>>>   		};
>>> -		partition at 0x40000 {
>>> +		partition at 40000 {
>>>   			label = "kernel";
>>>   			reg = <0x40000 0x200000>;
>>>   		};
>>> -		partition at 0x240000 {
>>> +		partition at 240000 {
>>>   			label = "file-system";
>>>   			reg = <0x240000 0x3dc0000>;
>>>   		};
>>
>> --
>> Lee Jones
>> Linaro ST-Ericsson Landing Team Lead
>> Linaro.org ? Open source software for ARM SoCs
>> Follow Linaro: Facebook | Twitter | Blog
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
