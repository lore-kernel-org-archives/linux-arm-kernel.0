From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 7 Jul 2011 12:33:11 +0200
Subject: [PATCH 3/4] arm: mach-s3c2440: dma: fix section mismatch
In-Reply-To: <20110707102419.GM8286@n2100.arm.linux.org.uk>
References: <1310033919-4245-1-git-send-email-w.sang@pengutronix.de>
	<1310033919-4245-4-git-send-email-w.sang@pengutronix.de>
	<20110707102419.GM8286@n2100.arm.linux.org.uk>
Message-ID: <20110707103311.GB1971@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> What do you think will happen when this list is walked, but your
> s3c2440_dma_driver structure has been discarded with the init section
> and replaced with random data?

OOPS. That was not enough love, mea culpa.

Thanks!

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110707/e15a53cb/attachment.sig>
