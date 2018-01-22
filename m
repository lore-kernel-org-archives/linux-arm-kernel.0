From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Jan 2018 12:36:32 +0100
Subject: [PATCH] ARM: pxa/tosa-bt: add MODULE_LICENSE tag
In-Reply-To: <87bmhpahs2.fsf@belgarion.home>
References: <20180110162816.431038-1-arnd@arndb.de>
 <87vag9bh1g.fsf@belgarion.home>
 <CAK8P3a1VeN0kLrJ5T57y46NR1GNviwZ=6baaXgSm9ZqYBnGuVA@mail.gmail.com>
 <87bmhpahs2.fsf@belgarion.home>
Message-ID: <CAK8P3a0e18Jsi+mndFoNY5pGmQw389MWyHv+aeXk=6Y9NY3oMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 19, 2018 at 6:18 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>
>> On Wed, Jan 10, 2018 at 9:22 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>>> Arnd Bergmann <arnd@arndb.de> writes:
>>>
>>>> Without this tag, we get a build warning:
>>>>
>>>> WARNING: modpost: missing MODULE_LICENSE() in arch/arm/mach-pxa/tosa-bt.o
>>>>
>>>> For completeness, I'm also adding author and description fields.
>>>>
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>
>>> Queued into pxa/for-next, thanks.
>>
>> I see now that you didn't send this back to arm at kernel.org. I assume you planned
>> to send it for 4.17, but kernelci now still reports the warning for
>> both 4.15 and
>> linux-next (4.16). Should we just include this patch in the 4.16 fixes
>> instead?
> Yeah sure, go ahead and merge it into 4.16 staging branch, with my :
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Applied to next/soc now, thanks!

     Arnd
