From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 10 Sep 2012 15:49:38 +0200
Subject: [PATCH 1/1] ARM: dts: OMAP3: Add gpio-twl4030 properties for Overo
In-Reply-To: <504DEDB4.1070804@ti.com>
References: <1347282996-31190-1-git-send-email-florian.vaussard@epfl.ch>
 <1347282996-31190-2-git-send-email-florian.vaussard@epfl.ch>
 <504DEA4E.7080109@ti.com> <504DEC36.4020704@epfl.ch>
 <504DEDB4.1070804@ti.com>
Message-ID: <504DEFF2.5060007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2012 03:40 PM, Benoit Cousson wrote:
> On 09/10/2012 03:33 PM, Florian Vaussard wrote:
>>>> Support the blue LED connected to the LEDB pin of the TWL4030
>>>> on the Gumstix Overo.
>>>>
>>>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>>>> ---
>>>>   arch/arm/boot/dts/omap3-overo.dtsi |   15 +++++++++++++++
>>>>   1 files changed, 15 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/omap3-overo.dtsi
>>>> b/arch/arm/boot/dts/omap3-overo.dtsi
>>>> index d6cc5e2..89808ce 100644
>>>> --- a/arch/arm/boot/dts/omap3-overo.dtsi
>>>> +++ b/arch/arm/boot/dts/omap3-overo.dtsi
>>>> @@ -13,6 +13,17 @@
>>>>
>>>>   /include/ "omap3.dtsi"
>>>>
>>>> +/ {
>>>
>>> BTW, I'm just wondering. Cannot we use overo without tobi?
>>>
>>> In that case, the model and compatible should probably be used as well:
>>>
>>>     model = "TI OMAP3 Gumstix Overo";
>>>     compatible = "ti,omap3-overo", "ti,omap3";
>>
>> No, it cannot. The Overo needs to be plugged into an expansion board, at
>> least to get the power. Hence the absence of model and compatible in
>> omap3-overo.dtsi.
> 
> OK, cool. I was wondering because we already have a board-overo.c in the
> kernel, and there is no mention of tobi.
> 
> OK, I'm adding that patch on top of the other then.

I'm just going to update the subject to:
ARM: dts: omap3-overo: Add support for the blue LED

regards,
Benoit
