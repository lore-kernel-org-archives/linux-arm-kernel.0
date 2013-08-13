From: bcousson@baylibre.com (Benoit Cousson)
Date: Tue, 13 Aug 2013 15:25:42 +0200
Subject: [PATCH] ARM: dts: am33xx: Correct gpio #interrupt-cells property
In-Reply-To: <201308071711.00449.poeschel@lemonage.de>
References: <1375873592-26881-1-git-send-email-larsi@wh2.tu-dresden.de>
 <20130807145309.GG28558@e106331-lin.cambridge.arm.com>
 <201308071711.00449.poeschel@lemonage.de>
Message-ID: <520A33D6.5070700@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi lars,

On 07/08/2013 17:11, Lars Poeschel wrote:
> On Wednesday 07 August 2013 at 16:53:09, Mark Rutland wrote:
>> On Wed, Aug 07, 2013 at 12:06:32PM +0100, Lars Poeschel wrote:
>>> From: Lars Poeschel <poeschel@lemonage.de>
>>>
>>> Following commit ff5c9059 and therefore other omap platforms using
>>> the gpio-omap driver correct the #interrupt-cells property on am33xx
>>> too. The omap gpio binding documentaion also states that
>>> the #interrupt-cells property should be 2.
>>
>> I take it there are no device nodes for which any of these nodes are an
>> interrupt parent (which would need to be updated)?
>
> As far as I know: No.
>
> Lars
>
>> If so:
>>
>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>>
>> Thanks,
>> Mark.
>>
>>> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>

Thank, applied with Mark and Javier A-By / R-By.

Thanks,
Benoit
