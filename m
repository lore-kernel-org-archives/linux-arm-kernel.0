From: tony@atomide.com (Tony Lindgren)
Date: Thu, 15 Mar 2012 10:51:22 -0700
Subject: [PATCH 1/2] ARM: OMAP: powerdomain: Wait for powerdomain
 transition in pwrdm_state_switch()
In-Reply-To: <alpine.DEB.2.00.1203151129160.26218@utopia.booyaka.com>
References: <1331562873-29535-1-git-send-email-santosh.shilimkar@ti.com>
 <1331562873-29535-2-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1203151129160.26218@utopia.booyaka.com>
Message-ID: <20120315175122.GB7276@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120315 10:35]:
> On Mon, 12 Mar 2012, Santosh Shilimkar wrote:
> 
> > Commit b1cbdb00d{OMAP: clockdomain: Wait for powerdomain to be ON
> > when using clockdomain force wakeup} was assuming that pwrdm_state_switch()
> > does wait for the powerdomain transition which is not the case.
> > 
> > Fix this API by adding the pwrdm_wait_transition().
> > 
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > CC: Rajendra Nayak <rnayak@ti.com>
> > CC: Paul Walmsley <paul@pwsan.com>
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>
> 
> Sounds like this fixes a major kernel oops bug for Tony so this should go 
> in ASAP to v3.3-rc series.

Got a random oops with this one applied still, just happened
to take longer this time :(

Regards,

Tony
