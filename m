From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 9 Sep 2011 15:42:44 +0200
Subject: [PATCH v2 3/3] arm: mxs: disable clock-gates when setting
	saif-clocks
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F77223E983@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1315403858-9904-1-git-send-email-b29396@freescale.com>
	<1315403858-9904-4-git-send-email-b29396@freescale.com>
	<20110907182442.GZ28816@pengutronix.de>
	<65EE16ACC360FA4D99C96DC085B3F77223E983@039-SN1MPN1-003.039d.mgd.msft.net>
Message-ID: <20110909134244.GU1912@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> For this patch, as discussed with Wolfram before, since we also find
> Some other devices have the same issue as SAIF(e.g. SSP),
> it looks we may have further work to do on clock-mx28.c.
> 
> However the original purpose of sending this patch is for
> poeple to easily test.

I will update this patch later on the train :)

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110909/079d2209/attachment.sig>
