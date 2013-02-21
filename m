From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 21 Feb 2013 08:55:39 +0100
Subject: [PATCH 3/3] pinctrl: imx: move hard-coding data into device tree
In-Reply-To: <20130221053020.GE17738@S2101-09.ap.freescale.net>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
 <1361344089-16804-4-git-send-email-shawn.guo@linaro.org>
 <51251E5A.1080806@wwwdotorg.org>
 <20130221053020.GE17738@S2101-09.ap.freescale.net>
Message-ID: <20130221075539.GI1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 21, 2013 at 01:30:22PM +0800, Shawn Guo wrote:
> On Wed, Feb 20, 2013 at 12:04:58PM -0700, Stephen Warren wrote:
> > There are a couple of potential issues with this patch, which I'm in two
> > minds about:
> > 
> > 1)
> > 
> > This is an incompatible change to the DT binding definition. A DT
> > written to the old specification won't work with a newer kernel and
> > vice-versa. This isn't supposed to happen with device tree.
> > 
> > Right now I believe we're still being flexible about DT binding changes,
> > but I've seen hints that this kind of thing will start getting lots of
> > push-back in the near future...
> > 
> Last time I heard of the time frame about doing this is when we get
> device tree source maintained in a separate repository from the kernel
> tree.  I'm not sure how far we're still away from that.  But most of
> sub-architectures (including IMX) have not been converted over to
> device tree.  And as far as I know, none of IMX based product runs
> device tree kernel yet.

The nature of open source makes it hard to know which devices ship out
there, so please don't assume there are none just because you know of
none.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
