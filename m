From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 7 Dec 2017 17:52:28 +0100
Subject: [PATCH v2] clocksource: tcb_clksrc: Fix clock speed message
In-Reply-To: <99fd8a35-9522-bb80-9aea-e4c266cdbc62@microchip.com>
References: <20171201122233.21828-1-romain.izard.pro@gmail.com>
 <6f3d309e-2e71-3f60-5910-0d8b1f051836@linaro.org>
 <99fd8a35-9522-bb80-9aea-e4c266cdbc62@microchip.com>
Message-ID: <4f811006-1c3e-f92c-7623-0839ddcd18de@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2017 17:34, Nicolas Ferre wrote:
> On 07/12/2017 at 12:01, Daniel Lezcano wrote:
>> On 01/12/2017 13:22, Romain Izard wrote:
>>> The clock speed displayed at boot in an information message was 500 kHz
>>> too high compared to its real value. As the value is not used anywhere,
>>> there is no functional impact.
>>>
>>> Fix the rounding formula to display the correct value.
>>>
>>> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
>>> ---
>>> v2: rebase over v4.15-rc1
>>>
>>> There is no specified maintainer for this file, only supporters.
>>
>> That is not correct, it defaults to Thomas and me, the maintainers of
>> drivers/clocksource :)
>>
>>> Nicolas, could you pick this through the at91 tree as the TCB block
>>> is an AT91 peripheral ?
>>
>> Nicolas, do you agree with this change ? If yes, I will take it.
> 
> Yes, fine with me:
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Thanks Daniel for the "heads-up".

Thanks, applied 4.16.


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
