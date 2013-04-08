From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 8 Apr 2013 23:31:30 +0200
Subject: [PATCHv7 08/17] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <CAErSpo7fGPe3wFha36kNMxeRP4gBpBWgfw85aTLey-DSz2ZYew@mail.gmail.com>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364395234-11195-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo7fGPe3wFha36kNMxeRP4gBpBWgfw85aTLey-DSz2ZYew@mail.gmail.com>
Message-ID: <201304082331.30809.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 April 2013, Bjorn Helgaas wrote:
> On Wed, Mar 27, 2013 at 8:40 AM, Thomas Petazzoni
> 
> > diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> > new file mode 100644
> > index 0000000..3ad563f
> > --- /dev/null
> > +++ b/drivers/pci/host/Makefile
> > @@ -0,0 +1,4 @@
> > +obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
> > +CFLAGS_pci-mvebu.o += \
> > +       -I$(srctree)/arch/arm/plat-orion/include \
> > +       -I$(srctree)/arch/arm/mach-mvebu/include
> 
> Too bad to have to adjust CFLAGS here.  Seems like I remember earlier
> discussion, but I didn't pay much attention, and if this is the best
> we can do, I guess it's OK.

I'm pretty sure I NAK'ed this part. I'm surprised it's still there.


	Arnd
