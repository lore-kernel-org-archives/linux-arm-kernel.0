From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 2 Feb 2010 09:44:00 +0100
Subject: Uncompressing broken with commit e7db7b4270
In-Reply-To: <20100201224854.GA2534@pc-ran3241>
References: <1264698229.7064.93.camel@pc1117.cambridge.arm.com>
	<20100201224854.GA2534@pc-ran3241>
Message-ID: <20100202084400.GB22848@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Feb 01, 2010 at 11:56:27PM +0100, Albin Tonnerre wrote:
> On Thu, 28 Jan 2010 17:03 +0000, Catalin Marinas wrote :
> > Hi,
> > 
> > For whatever reason, with commit e7db7b4270 (arm: add support for
> > LZO-compressed kernels) if the kernel Image goes beyond a certain size
> > it fails to uncompress. Reverting this commit solves the problem.
> > Removing some random kernel features also solves the uncompressing as
> > the kernel image gets smaller.
> > 
> > Any idea?
> 
> I'm going to be really busy with school for the next 2 weeks, so unless someone
> has time to dig into the issue, maybe the best option would be to revert this
> patch.
I'll spend some time looking into it.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
