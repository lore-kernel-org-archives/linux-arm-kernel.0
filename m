From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 29 Aug 2011 15:50:23 +0200
Subject: [alsa-devel] [PATCH 3/3] arm: mxs: disable clock-gates when
	setting saif-clocks
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7722274D9@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1313946314-3891-1-git-send-email-b29396@freescale.com>
	<20110829130747.GL24524@pengutronix.de>
	<65EE16ACC360FA4D99C96DC085B3F7722274D9@039-SN1MPN1-001.039d.mgd.msft.net>
Message-ID: <20110829135023.GO24524@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Sorry, i know that, I failed to apply the patch from your mail directly,
> so I applied manually. But if applied manually, the sign off was changed
> to my name. I did't know how to fix it.

As said, no problem, thought you overlooked it. One way to fix it:

	git commit --amend --author="The name <the@address.com>"

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110829/7cb7ae3a/attachment.sig>
