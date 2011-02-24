From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 24 Feb 2011 14:16:55 +0800
Subject: [PATCH v2 5/5] mmc: sdhci-esdhc: enable esdhc on imx53
In-Reply-To: <20110222155130.GJ2755@pengutronix.de>
References: <1298369606-29972-1-git-send-email-Hong-Xing.Zhu@freescale.com>
	<1298369606-29972-5-git-send-email-Hong-Xing.Zhu@freescale.com>
	<20110222113222.GE2755@pengutronix.de>
	<AANLkTimbx6=YvRHFuVkmPVYvYtwME31PxXWNHNfFsVRQ@mail.gmail.com>
	<20110222155130.GJ2755@pengutronix.de>
Message-ID: <20110224061653.GA3657@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Tue, Feb 22, 2011 at 04:51:30PM +0100, Wolfram Sang wrote:
> 
> > > Thanks for respinning \o/ This approach looks better to me, but CCing
> > > Olof to comment on abstraction issues if he has them. Will do a deeper
> > > review later this week.
> > 
> > 
> > I like it! Definitely the right approach. Pushing quirks down into the
> > I/O accessors is definitely the only scalable way to handle all the
> > various buggy controllers out there.
> > 
> > Acked-by: Olof Johansson <olof@lixom.net>
> 
> Glad to hear that. I do have a few issues though, will report them later
> as mentioned before, it needs a bit of time.
What issues on what SoC/board did you find? Maybe we can help debug?

Thanks
Richard
> 
> -- 
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
