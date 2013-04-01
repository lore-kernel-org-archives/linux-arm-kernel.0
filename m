From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 1 Apr 2013 11:29:34 -0400 (EDT)
Subject: [PATCH v3 7/7] USB: OHCI: avoid conflicting platform drivers
In-Reply-To: <201303301256.19027.arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1304011128110.1036-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 30 Mar 2013, Arnd Bergmann wrote:

> > I guess this means the onus is now on me to split up ohci-hcd into a 
> > central library and separate bus drivers, like ehci-hcd...
> 
> The original plan in my teams was that Manjunath would do that after
> he was done with the simple conversion of the EHCI drivers. I think we
> can all agree now that it's better if you at least the groundwork instead.

Yes, it would be better for me to prepare for the general split-up.

> Please let us know if you would like Manjunath to continue with splitting
> out the OHCI back-ends into separate drivers, or if you think that there
> is no point given the quality of the earlier patches.

This is how people learn.  After I have taken care of the initial steps 
and converted a couple of the drivers, Manjunath can work on the rest.

Alan Stern
