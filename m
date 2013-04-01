From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 1 Apr 2013 11:27:14 -0400 (EDT)
Subject: [PATCH v3 2/7] USB: EHCI: make ehci-spear a separate driver
In-Reply-To: <201303311830.11338.arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1304011126190.1036-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 31 Mar 2013, Arnd Bergmann wrote:

> On Saturday 30 March 2013, Arnd Bergmann wrote:
> > > > In V3:
> > > >  -Detailed commit message added here about why this patch is required.
> > > >  -Eliminated ehci_spear_setup routine beacuse hcd registers
> > > >   directly setting in spear_ehci_hcd_drv_probe function.
> > > 
> > > Fix the grammar, please.
> > 
> > Done. I agree some of this is hardly legible.
> > 
> 
> I realized later that the other patches have similarly screwed up
> changelogs. I'll send a new version once you've commented on v4,
> so in case there is anything else I missed I'm not spamming everyone
> another time.

I still haven't checked the details of the last patch in the series 
(the OHCI changes).  However, for patches 1/6 - 5/6:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
