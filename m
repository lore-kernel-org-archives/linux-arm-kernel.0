From: mbizon@freebox.fr (Maxime Bizon)
Date: Thu, 24 Oct 2013 15:46:00 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <addbb1933c62983e0114eeda7ce51342.squirrel@twosheds.infradead.org>
References: <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com> <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
 <20131023174458.GC5208@netboy>
 <1382553982.31058.10.camel@sakura.staff.proxad.net>
 <20131024095232.27BBCC4039D@trevor.secretlab.ca>
 <1382614439.6040.16.camel@sakura.staff.proxad.net>
 <1382615278.8522.72.camel@shinybook.infradead.org>
 <1382616801.6040.26.camel@sakura.staff.proxad.net>
 <3726fd81259f84ef308ba9011ae35174.squirrel@twosheds.infradead.org>
 <1382619952.6040.57.camel@sakura.staff.proxad.net>
 <addbb1933c62983e0114eeda7ce51342.squirrel@twosheds.infradead.org>
Message-ID: <1382622360.6040.79.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 2013-10-24 at 13:14 +0000, David Woodhouse wrote:

> If DMA gives a performance boost for all workloads, what bloody idiot
> defined or reviewed a DT binding that didn't include the information which

who defined it:
  - hobbyist programmer without DMA knowledge 
  - hobbyist programmer without time
  - hobbyist programmer without datasheet access
  - SOC-vendor employed programmer with deadline

who reviewed it:
  - someone without time
  - someone without datasheet access
  - no-one (programmer was part of DT team :)

> It's the difference between doing it as a matter of course, and doing it
> only in the very rare "OMG we fucked up but we really *need* to fix it up
> this time" case.

we manage to screw syscalls, even with the amount of people that have
the ability to review them (as opposed to hardware when you need
datasheet)

few syscalls, lots of hardware.

-- 
Maxime
