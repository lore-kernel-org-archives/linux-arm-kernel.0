From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 24 May 2012 01:43:56 -0600 (MDT)
Subject: [PATCH] ARM: OMAP: PM: Lock clocks list while generating summary
In-Reply-To: <1337363799-22085-1-git-send-email-nm@ti.com>
References: <1337363799-22085-1-git-send-email-nm@ti.com>
Message-ID: <alpine.DEB.2.00.1205240143440.2572@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 May 2012, Nishanth Menon wrote:

> From: Todd Poynor <toddpoynor@google.com>
> 
> commit a53025724052b2b1edbc982a4a248784638f563d
> (OMAP: Add debugfs node to show the summary of all clocks)
> 
> Introduced clock summary, however, we are interested in seeing
> snapshot of the clock state, not in dynamically changing clock
> configurations as the data provided by clock summary will then be
> useless for debugging configuration issues. So, hold the common lock
> when dumping the clock summary.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> 
> [nm at ti.com: added commit message]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>

Thanks, queued for 3.5-rc.


- Paul
