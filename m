From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 1 Sep 2011 07:55:22 +0200
Subject: [PATCH 1/1] mmc: sdhci-esdhc: Change delay after setting clock
	from 100ms to 1ms
In-Reply-To: <1314856275-12131-1-git-send-email-tony.lin@freescale.com>
References: <1314856275-12131-1-git-send-email-tony.lin@freescale.com>
Message-ID: <20110901055522.GB22652@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2011 at 01:51:15PM +0800, Tony Lin wrote:
> 1ms is enough for hardware to change the clock to stable.
> 100ms is too long.

How do you know that? Can you be sure for PowerPC as well? Have you researched
why the original author of the code has chosen that value? If so, please update
your commit message with such infos.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110901/5ae74122/attachment.sig>
