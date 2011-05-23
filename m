From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 23 May 2011 08:25:01 +0200
Subject: [PATCH] mfd wm8350: allocate irq descs dynamically
In-Reply-To: <20110521112947.GB11887@sirena.org.uk>
References: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
	<1305878365-827-3-git-send-email-s.hauer@pengutronix.de>
	<alpine.LFD.2.02.1105201451160.3078@ionos>
	<20110520130721.GD10403@pengutronix.de>
	<alpine.LFD.2.02.1105201518030.3078@ionos>
	<20110521112947.GB11887@sirena.org.uk>
Message-ID: <20110523062501.GA20715@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Sat, May 21, 2011 at 12:29:47PM +0100, Mark Brown wrote:
> On Fri, May 20, 2011 at 03:19:44PM +0200, Thomas Gleixner wrote:
> > On Fri, 20 May 2011, Sascha Hauer wrote:
> > 
> > > On Fri, May 20, 2011 at 02:52:28PM +0200, Thomas Gleixner wrote:
> > > > On Fri, 20 May 2011, Sascha Hauer wrote:
> > > > > @@ -500,7 +500,17 @@ int wm8350_irq_init(struct wm8350 *wm8350, int irq,
> 
> Sascha, you should know to *always* CC maintainers on patches.  Don't
> apply this patch, and please engage with the feedback I posted when you
> sent an earlier version of this patch.

Sorry for this, should have added you to the cc list of that indivual
patch. I can't find your reply in my mail, could you send it again?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
