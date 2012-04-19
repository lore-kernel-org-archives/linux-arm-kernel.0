From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Apr 2012 16:24:53 +0000
Subject: [PATCH V2 1/3] lib: add support for stmp-style devices
In-Reply-To: <20120418092019.GB2232@pengutronix.de>
References: <1332368519-22660-1-git-send-email-w.sang@pengutronix.de>
 <20120418090551.GA30966@shlinux2.ap.freescale.net>
 <20120418092019.GB2232@pengutronix.de>
Message-ID: <201204191624.53976.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 April 2012, Wolfram Sang wrote:
> > 
> > I'm converting mxs-dma driver to be mach-independent which also needs
> > this patch.
> > 
> > Do you know when this will be merged?
> 
> Nope. I assumed it could go in via arm-soc, since it makes sense and
> Arnd used to comment this series. He is probably busy, currently.

I think that's fine to go in arm-soc, please send a pull request for this.

	Arnd
