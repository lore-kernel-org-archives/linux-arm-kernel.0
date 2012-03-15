From: tony@atomide.com (Tony Lindgren)
Date: Thu, 15 Mar 2012 16:40:05 -0700
Subject: [PATCH 1/2] ARM: OMAP: powerdomain: Wait for powerdomain
 transition in pwrdm_state_switch()
In-Reply-To: <alpine.DEB.2.00.1203151733360.5007@utopia.booyaka.com>
References: <1331562873-29535-1-git-send-email-santosh.shilimkar@ti.com>
 <1331562873-29535-2-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1203151129160.26218@utopia.booyaka.com>
 <20120315175122.GB7276@atomide.com>
 <alpine.DEB.2.00.1203151701290.2133@utopia.booyaka.com>
 <20120315232256.GC7276@atomide.com>
 <alpine.DEB.2.00.1203151733360.5007@utopia.booyaka.com>
Message-ID: <20120315234004.GD7276@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120315 16:36]:
> On Thu, 15 Mar 2012, Tony Lindgren wrote:
> 
> > It seems that I need this patch plus need to undo the wrong
> > serial muxing in commit 7496ba30 (ARM: OMAP2+: UART: Add default mux
> > for all uarts) to make my zoom3 boot reliably.
> 
> Okay.  Well want to take the powerdomain patch for the v3.3-rc series 
> then?

Uhh now got a random issue of "BUG: bad unlock balance detected"..
Random oopses seem less common now, but still not booting reliably.

Regards,

Tony
