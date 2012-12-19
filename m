From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 19 Dec 2012 09:37:28 -0800
Subject: [PATCH V5 2/2] ASoC: SAMSUNG: Add DT support for i2s
References: <1355395373-22058-1-git-send-email-padma.v@samsung.com>
 <1355395373-22058-3-git-send-email-padma.v@samsung.com>
 <20121219132414.2CF653E0AD7@localhost>
 <20121219170937.GV4985@opensource.wolfsonmicro.com>
Message-ID: <007401cdde0f$86096210$921c2630$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> Mark Brown wrote:
> >
> > On Wed, Dec 19, 2012 at 01:24:14PM +0000, Grant Likely wrote:
> > > On Thu, 13 Dec 2012 16:12:53 +0530, Padmavathi Venna
> > <padma.v@samsung.com> wrote:
> >
> > > > +- compatible : "samsung,samsung-i2s"
> >
> > > Isn't that kind of redundant?  :-)
> >
> > > The format of the compatible strings should be "<vendor>,<part-
> number>-
> > i2s".
> > > Please be specific about the part number that you're doing the binding
> > > for. For example; use "samsung,exynos4210-i2s" instead of
> > "samsung,exynos-i2s".
> >
> > There are actually versioned IPs here (where the versions are used
> > publically in a few places) but it's not clearly documented which is
> > which.  It would be reasonable to use the IP versions here I think.
> 
Oops, I'm resending due to problem of my e-mail client.

> I agree with Mark Brown. That makes sense, for example, see mfc.
> 	compatible = "samsung,mfc-v6"
> Same versioned IPs can be used on different SoCs, so in my opinion, in
this
> case, to use version is more clear.
> 

- Kukjin
