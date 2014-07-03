From: balbi@ti.com (Felipe Balbi)
Date: Thu, 3 Jul 2014 12:08:22 -0500
Subject: [RFC PATCH] tty: serial: Add 8250-core based omap driver
In-Reply-To: <CABxcv=nGPyK7SeQZ+W1ZEfBPQ-RraVTawyYuKOGz02df0g=6Qg@mail.gmail.com>
References: <20140702190944.GA567@drone.musicnaut.iki.fi>
 <CAOCHtYgxMeA+Arfe40XeFDEKuCJ8qo1RqNR0hYBGr_Wp6sRfdA@mail.gmail.com>
 <20140703073411.GX28884@atomide.com>
 <20140703132509.GA5814@saruman.home>
 <CAOCHtYi0JwRO12gHa+KFGH1k7pPk4TL40igwhzRRxutw-tqf6A@mail.gmail.com>
 <20140703140736.GF5814@saruman.home>
 <20140703154425.GC23309@earth.universe>
 <20140703155240.GU5814@saruman.home>
 <20140703160622.GE23309@earth.universe>
 <CABxcv=nGPyK7SeQZ+W1ZEfBPQ-RraVTawyYuKOGz02df0g=6Qg@mail.gmail.com>
Message-ID: <20140703170822.GB5814@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 06:19:47PM +0200, Javier Martinez Canillas wrote:
> On Thu, Jul 3, 2014 at 6:06 PM, Sebastian Reichel <sre@kernel.org> wrote:
> > Hi,
> >
> > On Thu, Jul 03, 2014 at 10:52:40AM -0500, Felipe Balbi wrote:
> >> > DT is supposed to contain information about the hardware, so it
> >> > should stay the same? I think there is no non-hackish way to decide
> >>
> >> compatible would change, at a minimum.
> >
> > why? I would expect it to stay the same (and the current patch uses
> > the same compatible strings).
> >
> 
> Exactly, the new driver must support all the compatible strings
> defined in Documentation/devicetree/bindings/serial/omap_serial.tx
> (which already does as you pointed out).
> 
> Otherwise the current drivers/tty/serial/omap-serial.c could never be
> removed since that would mean breaking DT backward compatibility.

that settles it then... good. I'll start testing this next week.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140703/6befb010/attachment.sig>
