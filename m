From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 19 Oct 2010 04:29:50 +0200
Subject: [PATCH 5/6] mmc: sdhci-of-esdhc: factor out common stuff
In-Reply-To: <20101018161355.GA21088@void.printf.net>
References: <1287138064-21385-1-git-send-email-w.sang@pengutronix.de>
	<1287138064-21385-6-git-send-email-w.sang@pengutronix.de>
	<20101018161355.GA21088@void.printf.net>
Message-ID: <20101019022950.GC3485@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

> > -#define ESDHC_HOST_CONTROL_RES	0x05
> > +#include "sdhci-esdhc.c"
> 
> Stephen reports a -next build failure after this patch.  Presumably this
> should be sdhci-esdhc.h?  It's confusing that no-one else hit this.

Uh, ouch, one brown paper bag, please! Yeah, confusing, that is.

Regarding your patch:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101019/ea6e72c6/attachment.sig>
