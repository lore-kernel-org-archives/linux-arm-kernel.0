From: khilman@ti.com (Kevin Hilman)
Date: Mon, 27 Jun 2011 09:50:15 -0700
Subject: [GIT PULL] misc. OMAP PM updates for v3.1
In-Reply-To: <20110627112843.GN23145@atomide.com> (Tony Lindgren's message of
	"Mon, 27 Jun 2011 04:28:43 -0700")
References: <87vcvw5akk.fsf@ti.com> <20110627112843.GN23145@atomide.com>
Message-ID: <87oc1jcj7c.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [110623 17:32]:
>> Tony,
>> 
>> Please pull the following misc. OMAP PM updates targetted for v3.1.
>> 
>> This branch is based on your 'fixes' branch due to some dependencies.
>>       OMAP2: PM debug: move wakeup timer into clockevent code
>
> This won't work with the devel-timer branch. I think we should just
> drop it for now based on what I mentioned in the other thread.

Hmm, so it's not just the wakeup timer that conflicts between
devel-timer and my pm-misc branch.

My branch also removes a bunch of other stuff from pm-debug.c and pm.h
so it has overlapping changes with your devel-timer branch.

The conflicts are easy enough to resolve since both branches are just
removing code.

Is your devel-timer branch stable now?  Should I rebase my branch on top
of devel-timer?  or can you just handle the conflicts?

Kevin
