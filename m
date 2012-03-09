From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 9 Mar 2012 11:04:08 -0700 (MST)
Subject: [PATCH] ARM: OMAP4: clock: Add aliases for McBSP fclk clocks
In-Reply-To: <alpine.DEB.2.00.1203091101400.7039@utopia.booyaka.com>
References: <1331024133-18201-1-git-send-email-peter.ujfalusi@ti.com>
 <4F5A258F.8050704@ti.com> <20120309180027.GF12083@atomide.com>
 <alpine.DEB.2.00.1203091101400.7039@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1203091103450.7039@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Mar 2012, Paul Walmsley wrote:

> Please let's not merge this one yet.  It should not be necessary to change 
> the clkdev aliases, this change should occur in the hwmod code.

Sorry, sent this too quickly.  Not the hwmod code, but the opt_clks 
aliases in the hwmod data.


- Paul
