From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Mar 2012 12:27:21 -0700
Subject: [GIT PULL] omap fixes for merge window
In-Reply-To: <20120329185626.GY9859@atomide.com>
References: <20120321180536.GK9859@atomide.com>
 <CAOesGMiKc5Tc2e5X9=gSiFS87JtMWGmmtOLSStWJcO7ayoE6Rg@mail.gmail.com>
 <20120329144151.GS9859@atomide.com>
 <20120329185626.GY9859@atomide.com>
Message-ID: <CAOesGMjNJZTFo_t+-O97kuB_Ob-V+1skCPzJvncN3b6R5b1ptg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 11:56 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [120329 07:44]:
>> * Olof Johansson <olof@lixom.net> [120328 22:04]:
>> > Hi Tony,
>> >
>> > On Wed, Mar 21, 2012 at 11:05 AM, Tony Lindgren <tony@atomide.com> wrote:
>> > > Hi Arnd & Olof,
>> > >
>> > > Here's a set of fixes that would be nice to get merged during
>> > > the merge window before the GPIO changes get merged to avoid
>> > > boot issues on many omap boards.
>> > >
>> > > The changes queued in the GPIO tree require getting rid of
>> > > OMAP_GPIO_IRQ and use gpio_to_irq() instead. This is needed for
>> > > dynamically allocated GPIO interrupt ranges.
>> >
>> > Sorry for the slow response on this, we've been focused on getting the
>> > main pulls going in. I'm about to start a fixes branch now and looked
>> > at this pull request.
>> >
>> > I replied to one of the original patches in this branch, they need to
>> > be fixed before they can go in:
>> >
>> > http://marc.info/?l=linux-omap&m=133299716528617&w=2
>>
>> Thanks, that's a good catch.
>>
>> > Also, that way we can get a clean branch based on current mainline
>> > without merge conflicts.
>>
>> Yes will do.
>
> Olof, here's an updated pull request for your fixes staging branch.
>
> This contains the updated gpio_to_irq patches from Tarun, and a trivial
> build fix from Govindraj to #include <asm/system_misc.h> in pm.c.
> The DSI mux patch is the same.
>
> Note that the branch name is now just fixes as the necessary commits
> are now all in the mainline tree.
>
> Regards,
>
> Tony
>
>
> The following changes since commit 0195c00244dc2e9f522475868fa278c473ba7339:
> ?Linus Torvalds (1):
> ? ? ? ?Merge tag 'split-asm_system_h-for-linus-20120328' of git://git.kernel.org/.../dhowells/linux-asm_system
>
> are available in the git repository at:
>
> ?git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixe

Thanks, pulled.


-Olof
