From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Jan 2018 17:02:25 +0100
Subject: [PATCH] ARM: pxa/tosa-bt: add MODULE_LICENSE tag
In-Reply-To: <87vag9bh1g.fsf@belgarion.home>
References: <20180110162816.431038-1-arnd@arndb.de>
 <87vag9bh1g.fsf@belgarion.home>
Message-ID: <CAK8P3a1VeN0kLrJ5T57y46NR1GNviwZ=6baaXgSm9ZqYBnGuVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 9:22 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>
>> Without this tag, we get a build warning:
>>
>> WARNING: modpost: missing MODULE_LICENSE() in arch/arm/mach-pxa/tosa-bt.o
>>
>> For completeness, I'm also adding author and description fields.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Queued into pxa/for-next, thanks.

I see now that you didn't send this back to arm at kernel.org. I assume you planned
to send it for 4.17, but kernelci now still reports the warning for
both 4.15 and
linux-next (4.16). Should we just include this patch in the 4.16 fixes instead?

       Arnd
