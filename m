From: tony@atomide.com (Tony Lindgren)
Date: Sat, 6 Oct 2012 08:40:52 -0700
Subject: [PATCH v2 2/7] ARM: virt: allow the kernel to be entered in
 HYP mode
In-Reply-To: <alpine.LFD.2.02.1210061129080.16518@xanadu.home>
References: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com>
 <1347036934-8519-3-git-send-email-marc.zyngier@arm.com>
 <20121005200822.GQ3874@atomide.com>
 <6d3553bfe8a2d1ac88cab852100616a7@localhost>
 <20121006144252.GY3874@atomide.com>
 <alpine.LFD.2.02.1210061129080.16518@xanadu.home>
Message-ID: <20121006154052.GB3874@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nicolas.pitre@linaro.org> [121006 08:33]:
> On Sat, 6 Oct 2012, Tony Lindgren wrote:
> 
> > * Marc Zyngier <marc.zyngier@arm.com> [121006 03:19]:
> > 
> > > If so, that indicates some side effect of the safe_svcmode_maskall macro,
> > > and I suspect the "movs pc, lr" bit.
> > > 
> > > Can you try the attached patch? It basically falls back to the previous
> > > behaviour if not entered in HYP mode.
> > 
> > Yes, with this it boots OK.
> 
> OK. In that case, I suggest this patch be sent to Russell to fix this 
> issue so he could push the ARM stuff to Linus ASAP.
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>

Yes we can come back to this:

Tested-by: Tony Lindgren <tony@atomide.com>
