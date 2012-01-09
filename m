From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Jan 2012 12:17:12 +0000
Subject: [PATCH] ARM: PXA: Zipit Z2: Fix oops in z2_power_off
In-Reply-To: <201201091313.31535.marek.vasut@gmail.com>
References: <1326011616-3546-1-git-send-email-anarsoul@gmail.com>
 <201201090058.44041.marek.vasut@gmail.com>
 <CA+E=qVcYsa487rSAa48ZrJU64f1z1bbNXgjDnq23Y45WqwiXMg@mail.gmail.com>
 <201201091313.31535.marek.vasut@gmail.com>
Message-ID: <20120109121712.GN21765@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 01:13:31PM +0100, Marek Vasut wrote:
> > 2012/1/9 Marek Vasut <marek.vasut@gmail.com>:
> > >> Nope, it does not work. Looks like device disables power on memory in
> > >> deepsleep.
> > > 
> > > Why?
> > 
> > In deepsleep PXA27x deasserts SYS_EN pin, and looks like when it's
> > deasserted there's no power on SDRAM (on Zipit). Just guess.
> 
> Then maybe implement suspend-to-disk ? There was a patch for omap on the list, 
> maybe it's even merged.

What are hell you going on about?  Why would someone want to even try
implementing suspend-to-disk in the power off hook?  Why would you even
want to try to preserve the system state in a power off hook?

Nothing much you've said in this thread makes sense so far.  What is
the point you're trying to raise, other than a personal dislike for
using the deep sleep mode to simulate an apparant 'power off' condition?
