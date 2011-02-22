From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 22 Feb 2011 20:55:04 +0100
Subject: [PATCH 4/5] arm: mach-mx3: pcm043: add write-protect and
	card-detect for SD1
In-Reply-To: <AANLkTi=cDkuo9Q1Eqzno=_FKLN+0pNBCdvD=SqFsysVf@mail.gmail.com>
References: <1298379500-27590-1-git-send-email-w.sang@pengutronix.de>
	<1298379500-27590-5-git-send-email-w.sang@pengutronix.de>
	<AANLkTi=cDkuo9Q1Eqzno=_FKLN+0pNBCdvD=SqFsysVf@mail.gmail.com>
Message-ID: <20110222195504.GA9046@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +#define SD1_GPIO_WP    IMX_GPIO_NR(2, 23)
> +#define SD1_GPIO_CD     IMX_GPIO_NR(2, 24)

Probably you noticed by now, but the next patch does that for the whole
directory :)

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110222/9f7b6640/attachment.sig>
