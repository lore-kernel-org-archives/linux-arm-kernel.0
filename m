From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 14 Jan 2012 12:43:57 +0100
Subject: [PATCH 09/15] ARM: ux500: convert to twd_local_timer_register()
 interface
In-Reply-To: <4F0EE75D.7090504@arm.com>
References: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
 <1326287334-1905-10-git-send-email-marc.zyngier@arm.com>
 <CACRpkdaePjAAkbE7QW-SP4FMa8Wx8LonqBpN+CdzwjOuYE8WVA@mail.gmail.com>
 <4F0EE75D.7090504@arm.com>
Message-ID: <CACRpkdZBNUZ--sh=-9Zm_GB5QRqixNrCK=C92Xm9oMim7SrNPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 2:59 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 11/01/12 23:53, Linus Walleij wrote:
>> On Wed, Jan 11, 2012 at 2:08 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>
>>> Add support for the new smp_twd runtime registration interface
>>> to the ux500 platforms, and remove the old compile-time support.
>>>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>
>> Looks good! There will be collisions with the plat-nomadik
>> timers I sent out yesterday, so I don't know if it makes sense
>> to bring all timer stuff on a single ARM-SoC branch?
>> (Or the SoC maintainers rely on git rerere...)
>
> I guess I could collect all timer patches in a single branch if that's
> helpful to anyone.

I was more thinking along the lines of doing timer consolidation
on a single branch in ARM-SoC, so I'll include a note on that
when I ask Arnd+Olof to pull my changes, and let them decide.

Yours,
Linus Walleij
