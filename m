From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Jul 2013 11:07:23 +0100
Subject: [PATCH 3/3] ARM:dts:vf610-twr:Enable DSPI0 devices and Flash
 at26df081a
In-Reply-To: <20130709052925.GD16656@S2101-09.ap.freescale.net>
References: <1373272622-29064-1-git-send-email-b44548@freescale.com>
 <1373272622-29064-3-git-send-email-b44548@freescale.com>
 <20130708113600.GU27646@sirena.org.uk>
 <20130709052925.GD16656@S2101-09.ap.freescale.net>
Message-ID: <20130709100723.GS27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 01:29:27PM +0800, Shawn Guo wrote:
> On Mon, Jul 08, 2013 at 12:36:01PM +0100, Mark Brown wrote:

> > This should be fine to merge via arm-soc, it's no real dependency on the
> > actual SPI driver.

> It has dependency on the actual SPI driver where the DT bindings are
> defined, so I would only take the patches after the driver parts gets
> accepted.

The bindings are all totally generic ones for a SPI controller, there's
nothing controversial or even device specific about them so I'm happy to
say the bindings are fine as-is.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130709/06099851/attachment.sig>
