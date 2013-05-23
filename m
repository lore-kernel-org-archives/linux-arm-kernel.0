From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 23 May 2013 13:37:38 -0400 (EDT)
Subject: [RFC V6 PATCH 3/3] USB: OHCI: make ohci-pci a separate driver
In-Reply-To: <201305231901.21632.arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1305231335531.925-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 May 2013, Arnd Bergmann wrote:

> On Thursday 23 May 2013, Alan Stern wrote:
> > On Thu, 23 May 2013, Manjunath Goudar wrote:
> 
> > Also, you left out one thing that should still be here.  What happened 
> > to the part about changing
> > 
> > #if	!defined(PCI_DRIVER) &&		\
> > 
> > to
> > 
> > #if	!ENABLED(CONFIG_USB_OHCI_HCD_PCI) &&	\
> > 
> 
> This section of the driver is gone now since 86510bb248 "USB: OHCI: 
> clarify Kconfig dependencies", so the change is no longer needed.

I don't know what tree you're referring to.  That commit is not present
in Greg's usb-linus or usb-next branches.  The usb-next branch is what 
I use for new development.

Alan Stern
