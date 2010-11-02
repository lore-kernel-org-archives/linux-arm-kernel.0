From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 2 Nov 2010 16:09:45 +0100
Subject: [RFC][PATCH 1/1] ARM: Add initial hibernation support
In-Reply-To: <4CD00106.8000001@panicking.kicks-ass.org>
References: <201007150648.50521.marek.vasut@gmail.com>
	<201007150804.06217.marek.vasut@gmail.com>
	<4CD00106.8000001@panicking.kicks-ass.org>
Message-ID: <201011021609.45160.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 November 2010 13:16:06 Michael Trimarchi wrote:
> Hi Marek
> 
> Marek Vasut wrote:
> > Dne ?t 15. ?ervence 2010 08:00:28 Hiroshi DOYU napsal(a):
> >> From: ext Marek Vasut <marek.vasut@gmail.com>
> >> Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
> >> Date: Thu, 15 Jul 2010 07:56:11 +0200
> >> 
> >>> Dne ?t 15. ?ervence 2010 07:39:31 Hiroshi DOYU napsal(a):
> >>>> From: ext Marek Vasut <marek.vasut@gmail.com>
> >>>> Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
> >>>> Date: Thu, 15 Jul 2010 06:48:50 +0200
> >>>> 
> >>>>> Dne St 30. ?ervna 2010 16:28:01 Hiroshi DOYU napsal(a):
> >>>>>> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> >>>>>> 
> >>>>>> Hibernation (a.k.a: Suspend-To-Disk) support for ARM
> >>>>>> 
> >>>>>> Based on the original work from Romit and Raghu at TI. The original
> >>>>>> patch(*1) was sent to LOML by Teerth Reddy <teerth@ti.com>
> >>>>>> 
> >>>>>> *1: https://patchwork.kernel.org/patch/96442/
> >>>>>> 
> >>>>>> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> >>>>> 
> >>>>> Hey, can this also run on pre-v7 arms ? Or is there something I
> >>>>> missed that'd make that impossible?
> >>>> 
> >>>> What I verified is with OMAP3(Cortex A8) based board.
> >>>> 
> >>>> cp15 part has to be modified, but it might work without this part
> >>>> itself, I guess.
> >>> 
> >>> I see ... do I need any special support on the bootloader or userland
> >>> side ?
> >> 
> >> No, I don't think so. The resuming boot could set up most of states
> >> basically.
> > 
> > I'll test it on xscale/pxa270 ... if it works, I can test on various
> > pxa3xx too.
> 
> Have you done some test on pxa/xscale family?

Hi, didn't get the chance yet, but I believe there'll be need for changes in 
this stuff ... did anything new happen on the list about this ?

I'd suggest you to take this up on the list again.

NOTE: You'll also need to adjust this stuff for armv5 core and maybe even for 
xscale core.

Cheers
> 
> Michael Trimarchi
> 
> > --
> > 
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
