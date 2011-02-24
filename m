From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 24 Feb 2011 14:12:45 +0100
Subject: [PATCH V3 0/5] sdhci-esdhc-imx: use gpio for write protection
	and card detection
In-Reply-To: <87k4gp3bl1.fsf@lebrac.rtp-net.org>
References: <1298469118-25282-1-git-send-email-w.sang@pengutronix.de>
	<87k4gp3bl1.fsf@lebrac.rtp-net.org>
Message-ID: <20110224131245.GA2420@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'm getting a hard freeze on my efika sb and mx once I remove the
> unconditional BROKEN_CARD_DETECTION flag. I'm still investigating the
> issue. I'll keep you informed if I find something.

Hmm, this is probably an unhandled interrupt. Will see if I can get the
efika here...

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110224/8852c4d8/attachment.sig>
