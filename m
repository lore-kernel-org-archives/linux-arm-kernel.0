From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Dec 2010 14:49:49 +0000
Subject: Git pull request: ux500-core for the v2.6.38 merge window
In-Reply-To: <AANLkTim7iBkvqHrraRkMfrvQJjPHVccmSh=01hZxSyu-@mail.gmail.com>
References: <AANLkTim7iBkvqHrraRkMfrvQJjPHVccmSh=01hZxSyu-@mail.gmail.com>
Message-ID: <20101223144949.GO3636@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 23, 2010 at 08:48:26AM +0100, Linus Walleij wrote:
> Russell, could you please pull:
> 
>        git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> for-rmk
> 
> This is based on your devel branch due to the dependencies on the GIC
> cleanup patches

Basing stuff on the devel branch really doesn't work, especially as I'm
still getting a trickle of acks and tested-by's for the clksrc stuff.
Of course, I could chose not to publish such stuff in my devel branch,
thereby preventing it appearing in linux-next until the last moment
before the merge window.  Or I could just not ask for acks etc...

> as well as dependencies on some SMP consolidation patches hitting
> platsmp.c.

Is it possible to split this stuff up into two topic branches - one set
which doesn't depend on my GIC and SMP changes, and then we'll see what
can be done about the remainder?

What I'm thinking is maybe if I merge the GIC and SMP changes together,
and provide you with that as a basis for your dependents?

First, I need to make absolutely sure that the GIC and SMP changes are
100% ready and up to date with acks etc.  I think there may be patches
at the top of the SMP branch which haven't been posted to the list yet
(or they have but have no acks.)
