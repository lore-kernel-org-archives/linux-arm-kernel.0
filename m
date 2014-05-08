From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 8 May 2014 11:51:24 -0400 (EDT)
Subject: [PATCH 7/8] usb: ohci: sort out dependencies for lpc32xx and omap
In-Reply-To: <1399557141-1346645-8-git-send-email-arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1405081151000.1087-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 May 2014, Arnd Bergmann wrote:

> The dependency on the isp1301 driver is not something that
> should be in the main OHCI driver but rather the SoC specific
> part of it.
> 
> This moves the dependency for LPC32xx into USB_OHCI_HCD_LPC32XX,
> and changes the 'select ISP1301_OMAP' to a similar 'depends on'.
> Since the same dependency exists for the client driver, do the
> same change there.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-omap at vger.kernel.org
> Cc: Alan Stern <stern@rowland.harvard.edu>

For the host side changes:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
