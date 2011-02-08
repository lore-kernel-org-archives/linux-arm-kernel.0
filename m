From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 7 Feb 2011 21:16:25 -0700 (MST)
Subject: [PATCH v2 6/9] omap: dpll: Add allow_idle/deny_idle support for
	all DPLL's
In-Reply-To: <alpine.DEB.2.00.1102071952300.21991@utopia.booyaka.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
	<1296813544-25170-7-git-send-email-santosh.shilimkar@ti.com>
	<alpine.DEB.2.00.1102071952300.21991@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1102072115350.21991@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Feb 2011, Paul Walmsley wrote:

> Looks like you add the allow_idle/deny_idle functions for the OMAP3 CORE 
> DPLL, but you don't change mach-omap2/pm34xx.c.  Any reason for this?  It 
> seems that the current OMAP3 PM code doesn't enable CORE DPLL autoidle.  

Never mind - as Rajendra pointed out via private E-mail, that is done 
along with the PER DPLL autoidle in pm34xx.c.  So, the original patch is 
okay in this regard.


- Paul
