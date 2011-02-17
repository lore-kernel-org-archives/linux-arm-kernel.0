From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Feb 2011 15:39:09 -0800
Subject: [PATCH v5 3/5] OMAP4: hwmod data: add mailbox data
In-Reply-To: <AANLkTi=yj2_bS1h87u0hhUUpA=RPZe-A=PiNSf_q_66r@mail.gmail.com>
References: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
	<1296674843-12718-4-git-send-email-omar.ramirez@ti.com>
	<4D5943A9.8010205@ti.com>
	<AANLkTinA2a60TSM7qDC1LQiRaUTs0DR3bDMv+oVsVOE0@mail.gmail.com>
	<4D5AF8BA.8080403@ti.com>
	<AANLkTi=yj2_bS1h87u0hhUUpA=RPZe-A=PiNSf_q_66r@mail.gmail.com>
Message-ID: <20110217233908.GG20795@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ramirez Luna, Omar <omar.ramirez@ti.com> [110215 16:11]:
> 
> > If you have to do several platform_get_irq_byname to get this one, I'd
> > prefer to get rid of that name for OMAP4. It will make mailbox irq
> > consistent with the other hwmods.
> 
> I was thinking to standardize the names to be mbox0..mboxN across all
> the platforms, reason being that the mailbox also has capabilities to
> be used not only by dsp or iva, by using a polling method.
> 
> So even if the mailbox in OMAP3 is called "dsp", it has 4 more queues
> apart from the 2 used for messaging between arm and dsp, that could be
> used even if tidspbridge wasn't there.

So what's the status of this series? Can the rest of the patches
now be applied on top of the current omap-for-linus or do the names
still need fixing?

Tony
