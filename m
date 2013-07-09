From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 9 Jul 2013 23:02:04 +0800
Subject: [PATCH 3/3] ARM:dts:vf610-twr:Enable DSPI0 devices and Flash
 at26df081a
In-Reply-To: <20130709144425.GX27646@sirena.org.uk>
References: <1373272622-29064-1-git-send-email-b44548@freescale.com>
 <1373272622-29064-3-git-send-email-b44548@freescale.com>
 <20130708113600.GU27646@sirena.org.uk>
 <20130709052925.GD16656@S2101-09.ap.freescale.net>
 <20130709100723.GS27646@sirena.org.uk>
 <20130709125239.GA2813@S2101-09.ap.freescale.net>
 <20130709144425.GX27646@sirena.org.uk>
Message-ID: <20130709150202.GB2813@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 03:44:25PM +0100, Mark Brown wrote:
> On Tue, Jul 09, 2013 at 08:52:41PM +0800, Shawn Guo wrote:
> > On Tue, Jul 09, 2013 at 11:07:23AM +0100, Mark Brown wrote:
> 
> > > The bindings are all totally generic ones for a SPI controller, there's
> > > nothing controversial or even device specific about them so I'm happy to
> > > say the bindings are fine as-is.
> 
> > Am I missing something?  I do not even see a bindings doc in patch #1.
> > How can I think the bindings are fine?
> 
> Hrm, I was sure I was seeing one...  though in any case there's nothing
> here except for interrupt and DMA hookup so any additional properties
> aren't going to affect this patch.

You are probably talking about patch #2.  But this patch does add two
properties "spi-num-chipselects" and "bus-num".

Shawn
