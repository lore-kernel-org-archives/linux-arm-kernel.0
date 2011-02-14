From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 14 Feb 2011 09:51:10 -0700 (MST)
Subject: [PATCH v2 4/7] omap: dpll: Add allow_idle/deny_idle support for
	all DPLL's
In-Reply-To: <813a909da6bafa7ce0c15fa77d9d25b9@mail.gmail.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com>
	<1297329400-5936-2-git-send-email-rnayak@ti.com>
	<1297329400-5936-3-git-send-email-rnayak@ti.com>
	<1297329400-5936-4-git-send-email-rnayak@ti.com>
	<1297329400-5936-5-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1102121727140.21991@utopia.booyaka.com>
	<813a909da6bafa7ce0c15fa77d9d25b9@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1102140950300.21991@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Feb 2011, Rajendra Nayak wrote:

> Yes, the autogen scripts are updated, however they are
> currently in a separate branch (dpll-gatectrl).
> Will merge them into master soon.

OK, great.

> No real reason for not adding OMAP2 dpll autoidle support.
> Its just that I started off trying to do this for OMAP4, and
> then found me touching some omap3 stuff and hence
> also did it for OMAP3.(For some reason I thought there
> were no DPLL's in OMAP2).

That's fine, I have some patches in progress that enable this for the 
OMAP2 DPLL and APLLs.


- Paul
