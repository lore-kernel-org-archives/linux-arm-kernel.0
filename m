From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 19 Feb 2014 10:30:55 +0100
Subject: [PATCH v4 1/7] Documentation: Add device tree bindings for
 Freescale i.MX GPC
In-Reply-To: <2328803.HhaG6blXIR@wuerfel>
References: <1392737687-25003-1-git-send-email-p.zabel@pengutronix.de>
 <1392737687-25003-2-git-send-email-p.zabel@pengutronix.de>
 <2328803.HhaG6blXIR@wuerfel>
Message-ID: <1392802255.3445.18.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

[adding Samsung guys into the loop]

Am Dienstag, den 18.02.2014, 19:10 +0100 schrieb Arnd Bergmann:
> On Tuesday 18 February 2014 16:34:41 Philipp Zabel wrote:
> > +
> > +Example of a device that is part of a power domain:
> > +
> > +       vpu: vpu at 02040000 {
> > +               reg = <0x02040000 0x3c000>;
> > +               /* ... */
> > +               fsl,power-domain = <&pd_pu>;
> > +               /* ... */
> > +       };
> > +
> 
> I'm really not too happy about platforms starting to add random
> bindings for power domains. Unfortunately I didn't catch exynos
> doing this first, but I don't want to see another platform like
> that.
> 
> Can we please come up with a proper generic power domain binding
> first and then add platform specific users?

what is the process here? I've seen the samsung bindings and copied the
pattern. I guess the Exynos bindings are set in stone, and the i.MX
power domains can be handled using the same bindings.

regards
Philipp
