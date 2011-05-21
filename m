From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 21 May 2011 12:29:47 +0100
Subject: [PATCH] mfd wm8350: allocate irq descs dynamically
In-Reply-To: <alpine.LFD.2.02.1105201518030.3078@ionos>
References: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
	<1305878365-827-3-git-send-email-s.hauer@pengutronix.de>
	<alpine.LFD.2.02.1105201451160.3078@ionos>
	<20110520130721.GD10403@pengutronix.de>
	<alpine.LFD.2.02.1105201518030.3078@ionos>
Message-ID: <20110521112947.GB11887@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2011 at 03:19:44PM +0200, Thomas Gleixner wrote:
> On Fri, 20 May 2011, Sascha Hauer wrote:
> 
> > On Fri, May 20, 2011 at 02:52:28PM +0200, Thomas Gleixner wrote:
> > > On Fri, 20 May 2011, Sascha Hauer wrote:
> > > > @@ -500,7 +500,17 @@ int wm8350_irq_init(struct wm8350 *wm8350, int irq,

Sascha, you should know to *always* CC maintainers on patches.  Don't
apply this patch, and please engage with the feedback I posted when you
sent an earlier version of this patch.
