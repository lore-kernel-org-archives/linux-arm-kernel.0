From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 8 Aug 2012 08:25:45 -0700
Subject: [PATCH 03/11] usb/ohci-omap: remove unused variable
In-Reply-To: <1344437248-20560-4-git-send-email-arnd@arndb.de>
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
 <1344437248-20560-4-git-send-email-arnd@arndb.de>
Message-ID: <20120808152545.GC15776@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 04:47:20PM +0200, Arnd Bergmann wrote:
> Commit c2e935a7d "USB: move transceiver from ehci_hcd and ohci_hcd to
> hcd and rename it as phy" removed the last use of the "ohci" variable
> in the usb_hcd_omap_remove function, but left the variable in place
> unused.
> 
> Without this patch, building omap1_defconfig results in:
> 
> In file included from drivers/usb/host/ohci-hcd.c:1013:0:
> drivers/usb/host/ohci-omap.c: In function 'usb_hcd_omap_remove':
> drivers/usb/host/ohci-omap.c:406:19: warning: unused variable 'ohci' [-Wunused-variable]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Richard Zhao <richard.zhao@freescale.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
