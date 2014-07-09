From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Jul 2014 03:26:56 -0700
Subject: [PATCH 3/3] arm: dts: dra7: fixup qspi entry
In-Reply-To: <53BD16F6.1030006@linutronix.de>
References: <1404844852-19980-1-git-send-email-bigeasy@linutronix.de>
 <1404844852-19980-3-git-send-email-bigeasy@linutronix.de>
 <53BD1444.6080603@ti.com> <53BD16F6.1030006@linutronix.de>
Message-ID: <20140709102655.GN28884@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140709 03:20]:
> On 07/09/2014 12:07 PM, sourav wrote:
> > Hi,
> 
> Hello, Sourav,
> 
> > The number is correct and is complaining just because the crossbar stuff
> > is not
> > put in. I had already posted a patch[1] to remove interrupt binding as
> > of now.
> > 
> > Hence, NAK for this patch.
> 
> Thank you for explanation. What is the status on the crossbar stuff? Is
> this comming any time soon? It seems that it is also stalling the
> networking pieces.

The drivers/irqchip related fixes are queued into linux next,
and I'm planning to queue the dts related changes for v3.17.

I might have the crossbar stuff in omap-for-v3.17/dt at some
point today.

Regards,

Tony

> > [1]: https://patchwork.kernel.org/patch/4364341/
