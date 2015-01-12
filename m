From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 12 Jan 2015 20:42:00 +0100
Subject: [PATCH v3 3/5] ARM: at91/dt: update udc compatible strings
In-Reply-To: <20150112193126.GC2858@saruman>
References: <1421060278-27329-1-git-send-email-boris.brezillon@free-electrons.com>
 <1421060278-27329-4-git-send-email-boris.brezillon@free-electrons.com>
 <20150112182349.GJ6525@saruman>
 <20150112201816.6e57fe74@bbrezillon>
 <20150112193126.GC2858@saruman>
Message-ID: <20150112204200.4ffefdd4@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Jan 2015 13:31:26 -0600
Felipe Balbi <balbi@ti.com> wrote:

> On Mon, Jan 12, 2015 at 08:18:16PM +0100, Boris Brezillon wrote:
> > Hi Felipe,
> > 
> > On Mon, 12 Jan 2015 12:23:49 -0600
> > Felipe Balbi <balbi@ti.com> wrote:
> > 
> > > On Mon, Jan 12, 2015 at 11:57:56AM +0100, Boris Brezillon wrote:
> > > > at91sam9g45, at91sam9x5 and sama5 SoCs should not use
> > > > "atmel,at91sam9rl-udc" for their USB device compatible property since
> > > > this compatible is attached to a specific hardware bug fix.
> > > > 
> > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > > 
> > > WARNING: DT compatible string "atmel,at91sam9g45-udc" appears un-documented -- check ./Documentation/devicetree/bindings/
> > > #177: FILE: drivers/usb/gadget/udc/atmel_usba_udc.c:1827:
> > > +       { .compatible = "atmel,at91sam9g45-udc" },
> > > 
> > > WARNING: DT compatible string "atmel,sama5d3-udc" appears un-documented -- check ./Documentation/devicetree/bindings/
> > > #178: FILE: drivers/usb/gadget/udc/atmel_usba_udc.c:1828:
> > > +       { .compatible = "atmel,sama5d3-udc" },
> > > 
> > > please fix and resend. Also, when resending, could you add Nicolas'
> > > Acked-by since he's already given it ?
> > 
> > Actually these compatible strings are documented in the first patch
> > (where they were introduced), but I'll send a v4 with Nicolas' ack.
> 
> heh, checkpatch stupidity :-) My bad.
> 

You took v3 of the first patch instead of v4.
Don't know if you can replace it (anyway, that's not such a big deal
since the only change is the commit message)...


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
