From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 11 Mar 2013 08:42:06 +0100
Subject: [PATCH v3 1/2] i.MX27: Add clock support for SAHARA2.
In-Reply-To: <20130311011926.GA14930@gondor.apana.org.au>
References: <1362137873-8827-1-git-send-email-javier.martin@vista-silicon.com>
 <1362137873-8827-2-git-send-email-javier.martin@vista-silicon.com>
 <20130304075306.GA1906@pengutronix.de>
 <CACKLOr2kuWXMreEFA4wqyYVRNnPwmEoHPM2+V+tN5P_1bQ+iJQ@mail.gmail.com>
 <20130310083401.GB10448@gondor.apana.org.au>
 <20130310230856.GU1906@pengutronix.de>
 <20130311011926.GA14930@gondor.apana.org.au>
Message-ID: <20130311074206.GY1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 11, 2013 at 09:19:26AM +0800, Herbert Xu wrote:
> On Mon, Mar 11, 2013 at 12:08:56AM +0100, Sascha Hauer wrote:
> > On Sun, Mar 10, 2013 at 04:34:01PM +0800, Herbert Xu wrote:
> > > > >
> > > > > https://patchwork.kernel.org/patch/1817741/
> > > > >
> > > > > So the change above becomes unnecessary
> > > > 
> > > > Very good. Then this patch can be safely dropped.
> > > 
> > > So should I take this patch or not?
> > 
> > This clk patch, no. The sahara patch, yes, if it is fine for you.
> 
> But will the second patch work fine without the first?

It will work once a device is registered. The necessary clocks for it
will be provided by the devicetree then.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
