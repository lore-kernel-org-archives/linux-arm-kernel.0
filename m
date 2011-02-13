From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 12 Feb 2011 17:28:18 -0700 (MST)
Subject: [PATCH v2 4/7] omap: dpll: Add allow_idle/deny_idle support for
	all DPLL's
In-Reply-To: <1297329400-5936-5-git-send-email-rnayak@ti.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com>
	<1297329400-5936-2-git-send-email-rnayak@ti.com>
	<1297329400-5936-3-git-send-email-rnayak@ti.com>
	<1297329400-5936-4-git-send-email-rnayak@ti.com>
	<1297329400-5936-5-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1102121727140.21991@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Feb 2011, Rajendra Nayak wrote:

> All OMAP3/4 dpll's support hardware level autogating.
> Populate allow_idle/deny_idle function pointers for all
> DPLL's in clkops.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, queued for 2.6.39.  Two questions though.  Was the OMAP4 
autogeneration script updated?  Also, any technical reason why you didn't 
add the OMAP2 DPLL?


- Paul
