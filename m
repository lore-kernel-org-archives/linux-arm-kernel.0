From: khilman@ti.com (Kevin Hilman)
Date: Fri, 07 Oct 2011 10:50:26 -0700
Subject: ARM SoC tree: OMAP PM dependency on tip irq/core
In-Reply-To: <201110071804.11494.arnd@arndb.de> (Arnd Bergmann's message of
	"Fri, 7 Oct 2011 18:04:11 +0200")
References: <87aa9mm8ts.fsf@ti.com> <4E877E29.7000309@gmail.com>
	<20111006195945.GQ6324@atomide.com> <201110071804.11494.arnd@arndb.de>
Message-ID: <87d3e8lmhp.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Thursday 06 October 2011, Tony Lindgren wrote:
>> * Rob Herring <robherring2@gmail.com> [111001 13:21]:
>> > On 09/30/2011 05:29 PM, Kevin Hilman wrote:
>> > > Hi Arnd,
>> > > 
>> > > Kevin Hilman <khilman@ti.com> writes:
>> > > 
>> > >> The upcoming OMAP4 PM series from Santosh[1] that we're planning to
>> > >> queue for v3.2 has a dependency[2] on a patch currently queued for v3.2
>> > >> in the irq/core branch of Thomas' tip tree[3].
>> > >>
>> > >> In the past, I noticed you merged external trees like this to solve
>> > >> dependencies.
>> > >>
>> > >> Could you pull the irq/core branch into your tree to meet this
>> > >> dependency?
>> > > 
>> > > On second thought, since Santosh's branch is the only one with this
>> > > dependency (and we also have a dependency on Russell's devel-stable)
>> > > I'll just build up a branch for Santosh's series that includes
>> > > rmk/devel-stable and tglx/irq-core.
>> > > 
>> > 
>> > Any new platforms will have a dependency on rmk/devel-stable with the
>> > mach header clean-up. I'll probably have a dependency on tglx's tree as
>> > well.
>> 
>> Sounds like Arnd should pull this into some branch then.
>
> I've pulled in rmk/devel-stable as a dependency now, thanks for
> reminding me of that.
>
> Thomas, where should I get the irq-core branch (or whichever
> I should wait for) to pull in as another dependency. Is that
> branch one that never gets rebased? 

git://tesla.tglx.de/git/linux-2.6-tip irq/core

I asked Thomas about this earlier when I was going to build up the
dependencies myself, and he said it won't be rebased.

Kevin
