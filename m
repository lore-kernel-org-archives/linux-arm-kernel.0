From: vapier@gentoo.org (Mike Frysinger)
Date: Fri, 28 Oct 2011 16:04:47 +0200
Subject: [PATCH] asm-generic/gpio.h: merge basic gpiolib wrappers
In-Reply-To: <CACRpkda4NvJeh3X6M57tV_9BbAvY99KQikxB+e0nXtABKU2mQg@mail.gmail.com>
References: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1319720503-3183-1-git-send-email-vapier@gentoo.org>
	<20111027131124.GK19187@n2100.arm.linux.org.uk>
	<CAJaTeTp71t0BYsEpDu07BE5ox2FBAiH7xEQqjhb=6QadrsQGAQ@mail.gmail.com>
	<20111028124200.GU19187@n2100.arm.linux.org.uk>
	<CACRpkda4NvJeh3X6M57tV_9BbAvY99KQikxB+e0nXtABKU2mQg@mail.gmail.com>
Message-ID: <CAJaTeTrbzVH15Hh-uRMvrJJUUPdhKMjL7Z4NwsN17oJLn190FA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2011 at 15:51, Linus Walleij wrote:
> On Fri, Oct 28, 2011 at 2:42 PM, Russell King - ARM Linux wrote:
>> On Fri, Oct 28, 2011 at 02:15:00PM +0200, Mike Frysinger wrote:
>>>
>>> it's interesting you highlight davinci. ?if i'm reading things
>>> correctly, the current davinci code is broken today and my v2 proposed
>>> patch actually fixes it.
>>
>> That looks like an error in patch 5f3fcf9649dbb010ccac41259d04147775ec8fc2
>> (ARM: 7040/1: mach-davinci: break out GPIO driver specifics) which does
>> this:
>>
>> -#define __ARM_GPIOLIB_COMPLEX
>>
>> Linus, can you send a fix?
>
> OK I'm onto it.
>
> Sorry for the mess!

thanks ... i'll wait for the fix (please cc me) and redo my gpio
change on top of that.  i need to send a v3 anyways since the v2 does
break one platform.
-mike
