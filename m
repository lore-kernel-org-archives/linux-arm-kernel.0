From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 30 Mar 2013 11:37:20 +0000
Subject: [PATCH v3 1/7] USB: EHCI: make ehci-orion a separate driver
In-Reply-To: <Pine.LNX.4.44L0.1303291342540.1467-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1303291342540.1467-100000@iolanthe.rowland.org>
Message-ID: <201303301137.21039.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 March 2013, Alan Stern wrote:
> I don't know about this last phrase.  When someone is running "make 
> menuconfig", for example, what shows up is the symbol's description, 
> not the symbol's name.  That person would see "EHCI support for Marvell 
> on-chip controller", not "USB_EHCI_MV".
> 
> In fact, shouldn't the description for USB_EHCI_MV be changed too, to 
> make it more distinct from this one?
> 
> All the code changes are fine.

Ok, I've included these Kconfig changes. Originally, the text change
for PXA/MMP was included in the patch for ehci-mv, but that one is
deferred to 3.11 now because of dependencies for the platform code that
we want to first merge in 3.10.

	Arnd
