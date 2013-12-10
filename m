From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Dec 2013 10:00:22 +0000
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <20131210082547.GC11489@norris.computersforpeace.net>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <20131127043253.GA9468@ld-irv-0074.broadcom.com>
 <5298AA23.7080404@st.com> <529C5BBF.6000604@freescale.com>
 <529C6CBB.4000008@st.com> <529D7838.6030606@freescale.com>
 <20131203082343.GK31626@lee--X1>
 <20131210082547.GC11489@norris.computersforpeace.net>
Message-ID: <20131210100022.GA2390@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Dec 2013, Brian Norris wrote:

> On Tue, Dec 03, 2013 at 08:23:43AM +0000, Lee Jones wrote:
> > I would like to make a suggestion to Brian though. Even if the new
> > framework is written within the next couple of months and the
> > semantics do suit the FSM Controller driver, I'd still like the
> > implementation that's currently on the list to be applied. That way
> > we'd have a known good version of the driver which is almost identical
> > to how ST's internal driver does now. The one that is present out in
> > the wild (i.e. _real_ products).
> 
> I think this suggestion is feasible: that we might merge this driver
> even if it doesn't try to fit to some (still vague) idea of what a "SPI
> NOR framework" should be. However, I don't know if the latter argument
> is valid; just because it's in real products doesn't mean we really want
> it as-is.

True, it just makes things easier for us internally when we are due
for a kernel version up-lift.

> But I think that in this case, the perfect may be the enemy of
> the good -- the "good" driver now is better than the "perfect" driver
> that never comes.

+1

> > I will subsequently volunteer to provide my utmost best efforts to
> > port the driver over to the new framework as a new task once it has
> > landed.
> 
> I'll hold you to that! Do we have any collateral for that guarantee? ;)

My word is my bond Brian. Failing that, beer? :)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
