From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 22 Feb 2011 16:51:30 +0100
Subject: [PATCH v2 5/5] mmc: sdhci-esdhc: enable esdhc on imx53
In-Reply-To: <AANLkTimbx6=YvRHFuVkmPVYvYtwME31PxXWNHNfFsVRQ@mail.gmail.com>
References: <1298369606-29972-1-git-send-email-Hong-Xing.Zhu@freescale.com>
	<1298369606-29972-5-git-send-email-Hong-Xing.Zhu@freescale.com>
	<20110222113222.GE2755@pengutronix.de>
	<AANLkTimbx6=YvRHFuVkmPVYvYtwME31PxXWNHNfFsVRQ@mail.gmail.com>
Message-ID: <20110222155130.GJ2755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Thanks for respinning \o/ This approach looks better to me, but CCing
> > Olof to comment on abstraction issues if he has them. Will do a deeper
> > review later this week.
> 
> 
> I like it! Definitely the right approach. Pushing quirks down into the
> I/O accessors is definitely the only scalable way to handle all the
> various buggy controllers out there.
> 
> Acked-by: Olof Johansson <olof@lixom.net>

Glad to hear that. I do have a few issues though, will report them later
as mentioned before, it needs a bit of time.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110222/3b2754ad/attachment.sig>
