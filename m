From: jayakumar.lkml@gmail.com (Jaya Kumar)
Date: Tue, 24 May 2011 19:00:05 +0800
Subject: Updated mach-types update
In-Reply-To: <201105231839.57083.arnd@arndb.de>
References: <201105231652.28497.arnd@arndb.de>
	<20110523151051.GB6489@sirena.org.uk>
	<20110523153326.GB15153@n2100.arm.linux.org.uk>
	<201105231839.57083.arnd@arndb.de>
Message-ID: <BANLkTi=esTs+gTxGqbZc+TJgcna5OtmWhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2011 at 12:39 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> We need to do more of those before we see significant reductions from
> being able to remove a lot of the existing board files. At the same
> time, a number of people obviously have new boards that they want to
> see supported. The tactical answer that I'd give to them is that they
> can still add board files, provided that they also help do the work
> that is required to remove them later (depends the specific capabilities
> of the people and the complexity of the code they want to add).

Hi Arnd,

Thanks for the feedback. I think this thread went from the specific
case of this 2363, Wayland board into a broader discussion. I
understand this is because of the arm subarch cleanup goals. To help
people like me who aren't familiar with the details, could you
elaborate on "can still add board files" and "the work that is
required to remove them later". Do you mean I could still submit a
patch like arch/arm/mach-mmp/wayland* and you'd be willing to take it,
but with the expectation that it would be removed at a later date? Is
the removal work to do with adding device tree support (I assume
that's a bootloader task as well as a subarch/board support task)? I'm
happy to help with what I can but I'm very slow. I'm even having
trouble just getting mainline to boot on the board. [1]

Thanks,
jaya

[1] http://www.spinics.net/lists/arm-kernel/msg125769.html
