From: cjb@laptop.org (Chris Ball)
Date: Tue, 19 Oct 2010 03:36:42 +0100
Subject: [PATCH 5/6] mmc: sdhci-of-esdhc: factor out common stuff
In-Reply-To: <20101019022950.GC3485@pengutronix.de>
References: <1287138064-21385-1-git-send-email-w.sang@pengutronix.de>
	<1287138064-21385-6-git-send-email-w.sang@pengutronix.de>
	<20101018161355.GA21088@void.printf.net>
	<20101019022950.GC3485@pengutronix.de>
Message-ID: <20101019023642.GA11777@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 19, 2010 at 04:29:50AM +0200, Wolfram Sang wrote:
> > Stephen reports a -next build failure after this patch.  Presumably this
> > should be sdhci-esdhc.h?  It's confusing that no-one else hit this.
> 
> Uh, ouch, one brown paper bag, please! Yeah, confusing, that is.

Ah, not that confusing -- sdhci-of-esdhc.c essentially depends on PPC,
and MMC_SDHCI_ESDHC_IMX depends on ARM, and I imagine we've only had
testing on the latter.

> Regarding your patch:
> 
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Thanks.  When it comes time to send to Linus, I'll just roll this into
your original [5/6].

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
