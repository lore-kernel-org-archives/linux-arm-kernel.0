From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 15 Mar 2012 17:34:04 -0600 (MDT)
Subject: [PATCH 1/2] ARM: OMAP: powerdomain: Wait for powerdomain
 transition in pwrdm_state_switch()
In-Reply-To: <20120315232256.GC7276@atomide.com>
References: <1331562873-29535-1-git-send-email-santosh.shilimkar@ti.com>
 <1331562873-29535-2-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1203151129160.26218@utopia.booyaka.com>
 <20120315175122.GB7276@atomide.com>
 <alpine.DEB.2.00.1203151701290.2133@utopia.booyaka.com>
 <20120315232256.GC7276@atomide.com>
Message-ID: <alpine.DEB.2.00.1203151733360.5007@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Mar 2012, Tony Lindgren wrote:

> It seems that I need this patch plus need to undo the wrong
> serial muxing in commit 7496ba30 (ARM: OMAP2+: UART: Add default mux
> for all uarts) to make my zoom3 boot reliably.

Okay.  Well want to take the powerdomain patch for the v3.3-rc series 
then?

- Paul
