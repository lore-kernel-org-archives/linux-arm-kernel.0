From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 Dec 2013 09:10:20 -0800
Subject: [PATCH 5/8] gpio: twl4030: Fix regression for twl gpio output
In-Reply-To: <CACRpkdb1XEJjykRD3MGmjHvTX40JtTZU7uDRAvpGLBdoREChmw@mail.gmail.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-6-git-send-email-tony@atomide.com>
 <529DDCE3.5020902@ti.com>
 <CACRpkdb1XEJjykRD3MGmjHvTX40JtTZU7uDRAvpGLBdoREChmw@mail.gmail.com>
Message-ID: <20131209171020.GB11433@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [131209 05:10]:
> On Tue, Dec 3, 2013 at 2:30 PM, Roger Quadros <rogerq@ti.com> wrote:
> 
> (...)
> > This patch causes a regression with LED outputs (GPO) on twl4030 on 3.13-rc2.
> > As one of the LED GPO is used for USB host on beagleboard, it will cause failure
> > of USB host probe.
> (...)
> > Below is a proposed fix for this.
> 
> Roger, Tony: what happened with this? Have you hashed this out?
> I ACK Roger's fixup too if that needs to be merged into the OMAP
> tree.

There's an updated version from Roger posted that I acked:

[PATCH v2 1/1] gpio: twl4030: Fix regression for twl gpio LED output

http://lkml.org/lkml/2013/12/5/65

I also commented on the dependencies there, but basically you can
pick it up unless you want me to. Should be cc stable as well.

Regards,

Tony
