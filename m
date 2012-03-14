From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Mar 2012 10:01:00 +0100
Subject: [PATCH 3/3] led-triggers: create a trigger for CPU activity
In-Reply-To: <20120313161138.cbeb594d.akpm@linux-foundation.org>
References: <1331197863-25564-1-git-send-email-bryan.wu@canonical.com>
 <1331197863-25564-3-git-send-email-bryan.wu@canonical.com>
 <20120313161138.cbeb594d.akpm@linux-foundation.org>
Message-ID: <CACRpkdYMgRsJaKSNhChWvZGj497pgGYWTh26oSCXSYjYr8_JxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 12:11 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Thu, ?8 Mar 2012 17:11:03 +0800
> Bryan Wu <bryan.wu@canonical.com> wrote:
>
>> Attempting to consolidate the ARM LED code, this removes the
>> custom RealView LED trigger code to turn LEDs on and off in
>> response to CPU activity and replace it with a standard trigger.
>>
>> (bryan.wu at canonical.com:
>> It moves arch/arm/kernel/leds.c syscore stubs into this trigger.
>> It also provides ledtrig_cpu trigger event stub in <linux/leds.h>.
>> Although it was inspired by ARM work, it can be used in other arch.)
>
> The patch doesn't "remove" or "move" anything. ?It wholly consists of
> additions. ?Confused.
>
>> Cc: Richard Purdie <rpurdie@rpsys.net>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
>> Reviewed-by: Jamie Iles <jamie@jamieiles.com>
>> Tested-by: Jochen Friedrich <jochen@scram.de>
>
> The authorship is a bit unclear. ?You're the primary author, yes?

It's based on a patch I wrote ages ago, but I don't care much.
Since Bryan's been driving it since, let's say Bryan wrote it.
Just remove the signoff if it's confusing.

Linus Walleij
