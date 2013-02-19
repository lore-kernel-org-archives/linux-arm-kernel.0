From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 19 Feb 2013 10:26:27 -0500 (EST)
Subject: [PATCH 2/2] USB: EHCI: make ehci-orion a separate driver
In-Reply-To: <201302191056.07139.arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1302191025380.2215-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Feb 2013, Arnd Bergmann wrote:

> On Tuesday 19 February 2013, Manjunath Goudar wrote:
> > > This is not necessary; ehci_setup is the default value anyway.  This
> > > structure can be omitted.
> > >
> > 
> > ehci_init_driver function we are passing orion_overrides,if we are removing
> > above struct initialization, what should we need to pass in
> > the  ehci_init_driver function.
> > 
> 
> ehci_init_driver already checks if you pass an override in there, and does
> not override anything in that case, so you can simply pass NULL as the
> argument.

That's right.  Manjunath, you can answer at lot of questions like this 
for yourself very easily, simply by reading the source code.

Alan Stern
