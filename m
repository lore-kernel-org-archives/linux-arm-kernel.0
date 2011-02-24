From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 24 Feb 2011 12:40:10 +0100
Subject: [PATCH V3 0/5] sdhci-esdhc-imx: use gpio for write protection and
	card detection
In-Reply-To: <1298469118-25282-1-git-send-email-w.sang@pengutronix.de>
	(Wolfram Sang's message of "Wed, 23 Feb 2011 14:51:53 +0100")
References: <1298469118-25282-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <87k4gp3bl1.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram Sang <w.sang@pengutronix.de> writes:

Hi,

> Take #3, changes:
>
> * also intercept calls to SDHCI_SIGNAL_ENABLE (needed on mx25)
> * remove unconditional BROKEN_CARD_DETECTION (leftover)
> * improved kernel-doc about unused GPIO
> * added tags from Eric
>
> Tested now by me and Marc on mx35, Eric on mx25/35/51. Arnaud, did you have a
> chance to retest on mx51? What about the FSL guys? :)

I'm getting a hard freeze on my efika sb and mx once I remove the
unconditional BROKEN_CARD_DETECTION flag. I'm still investigating the
issue. I'll keep you informed if I find something.

Arnaud
