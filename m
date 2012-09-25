From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 Sep 2012 11:45:25 +0200
Subject: [PATCH 3/3] mmc: esdhc i.MX: Support 8bit mode
In-Reply-To: <20120925085040.GA14216@S2101-09.ap.freescale.net>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
 <1348471345-30785-4-git-send-email-s.hauer@pengutronix.de>
 <20120925071505.GG27291@S2101-09.ap.freescale.net>
 <20120925072714.GY1322@pengutronix.de>
 <20120925073317.GI27291@S2101-09.ap.freescale.net>
 <20120925073808.GZ1322@pengutronix.de>
 <20120925074548.GJ27291@S2101-09.ap.freescale.net>
 <20120925080525.GA1322@pengutronix.de>
 <20120925085040.GA14216@S2101-09.ap.freescale.net>
Message-ID: <20120925094525.GC1322@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 04:50:52PM +0800, Shawn Guo wrote:
> On Tue, Sep 25, 2012 at 10:05:25AM +0200, Sascha Hauer wrote:
> > Ok, how about this:
> > 
> > - I add a bus-width = <4> property to all i.MX dtsi files
> > - we merge the patch adding bus-width as an optional property
> > - Make the bus-width option mandatory in the next step.
> > 
> > This way we can merge the mmc related patches through the mmc tree and
> > the dts changes through arm-soc.
> > 
> Sounds good to me.  How the last step should be done will depend
> on the common spec.  Per Chris, there are already two drivers
> implementing the property as optional.  Not sure if Chris will change
> spec to have the property defined as optional (probably default to 1?).

It won't hurt if we add the property now for all i.MX. Then Chris is
free to do whatever he wants (at least from the i.MX perspective)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
