From: jochen@scram.de (Jochen Friedrich)
Date: Wed, 10 Aug 2011 15:11:11 +0200
Subject: [PATCH 02/18] led-triggers: create a trigger for CPU activity
In-Reply-To: <20110810130659.GE2680@pulham.picochip.com>
References: <1312977952-2272-1-git-send-email-bryan.wu@canonical.com>
	<1312977952-2272-3-git-send-email-bryan.wu@canonical.com>
	<20110810130659.GE2680@pulham.picochip.com>
Message-ID: <4E42836F.3030906@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.08.2011 15:06, Jamie Iles wrote:
> Hi Bryan,
>
> On Wed, Aug 10, 2011 at 08:05:36PM +0800, Bryan Wu wrote:
>> Attempting to consolidate the ARM LED code, this removes the
>> custom RealView LED trigger code to turn LEDs on and off in
>> response to CPU activity and replace it with a standard trigger.
>>
>> (bryan.wu at canonical.com:
>> It moves arch/arm/kernel/leds.c syscore stubs into this trigger.
>> It also provides ledtrig_cpu trigger event stub in<linux/leds.h>.
>> Although it was inspired by ARM work, it can be used in other arch.)
>>
>> Cc: Richard Purdie<rpurdie@rpsys.net>
>> Signed-off-by: Linus Walleij<linus.walleij@linaro.org>
>> Signed-off-by: Bryan Wu<bryan.wu@canonical.com>
>> ---
>
> This looks really nice and small now!
>
> Reviewed-by: Jamie Iles<jamie@jamieiles.com>
>
> Jamie

This works OK now on SIMpad devices :-)

Tested-by: Jochen Friedrich <jochen@scram.de>

Thanks,
Jochen
