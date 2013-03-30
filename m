From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 30 Mar 2013 12:29:59 +0000
Subject: [PATCH v3 5/7] USB: EHCI: make ehci-atmel a separate driver
In-Reply-To: <Pine.LNX.4.44L0.1303291600080.1467-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1303291600080.1467-100000@iolanthe.rowland.org>
Message-ID: <201303301229.59504.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 March 2013, Alan Stern wrote:

> While not absolutely necessary, it would be nice to have the #include 
> files in alphabetical order.
> 
> > +
> > +#include "ehci.h"
> > +
> > +#define DRIVER_DESC "EHCI atmel driver"
> 
> "atmel" should have a capital 'A'.
> 

Ok, added these changes for v4 along with Nicolas' Ack,
and removed the call to ehci_shutdown.

	Arnd
