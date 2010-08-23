From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 23 Aug 2010 17:26:41 +0200
Subject: Policy question: criteria for submission to mainline for a new
	SoC?
In-Reply-To: <AANLkTimpz2YVTqd1EVqoX3yKKQ-peAy=OgwEDmz-iVi-@mail.gmail.com>
References: <AANLkTimpz2YVTqd1EVqoX3yKKQ-peAy=OgwEDmz-iVi-@mail.gmail.com>
Message-ID: <201008231726.41399.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 23. srpna 2010 17:20:43 Jason McMullan napsal(a):
> Hi there! So, I have the responsibility of handling our Linux Kernel
> GPL requirements at Netronome for our NFP3200 series of processors
> (ARM MPCore based SoCs with 40 IXP style microengines), and I have
> some policy questions.
> 
> We (currently) have two products that the NFP3200 is mounted on,
> both of which are evaluation devices for our customers. We provide
> our customers *complete* source code for *all* GPL components
> (Linux, Busybox, root fs, etc. etc. etc).
> 
> We also provide our customers non-GPL components (custom bootloader,
> board initialization routines, etc), if they wish to go the uCOS
> or VxWorks path.

Most of the board init routines should be in Linux actually. It shouldn't depend 
on bootloader. Also, you might want to use uboot for linux instead of custom 
bootloader.
> 
> So our customers (and anyone who asks us for a copy of the GPL
> component sources) are covered, and, as far as I can tell, we are
> GPL compliant. (If not, let me know, and we'll fix it!)

Why not just sticking the sources on the website somewhere ?
> 
> However, I am not sure if it is worth cluttering up the Linux ARM
> arch mainline with yet another rare SoC. If the Linux ARM community
> would like the sources, I am more than willing to post them on
> the list, but there's not much new or interesting to see - just
> a lot of trivial SoC hardware details.

Please do.
> 
> So, the questions are:
> 
> A) Is anyone interested in the NFP3200 SoC patches?

Yes.
> 
> B) What is the general policy for '# of units sold' for whether
>    a SoC should be added to the Linux ARM mainline?

No, >= 1 should do.

Cheers
