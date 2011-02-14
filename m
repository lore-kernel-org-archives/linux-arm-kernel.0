From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Feb 2011 13:20:07 -0800
Subject: [PATCH 1/2] OMAP2420: mailbox: fix IVA vs DSP IRQ numbering
In-Reply-To: <1297454203-28298-1-git-send-email-khilman@ti.com>
References: <1297454203-28298-1-git-send-email-khilman@ti.com>
Message-ID: <20110214212007.GM20795@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110211 11:55]:
> The IRQ numbering for the IVA and DSP mailboxes was switched due
> to the wrong ordering in the OMAP2 mbox list.  Switch the ordering
> so DSP is first and matches all the other SoCs.
> 
> Tested on OMAP2420/n810.

I'll queue both as fixes for the -rc cycle.

Tony
