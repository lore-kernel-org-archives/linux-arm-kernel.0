From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 15 Oct 2013 11:26:24 -0400 (EDT)
Subject: [PATCH V2 5/7] USB: OHCI: Properly handle ohci-ep93xx suspend
In-Reply-To: <1381843202-28707-6-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1310151124090.1377-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Oct 2013, Majunath Goudar wrote:

> From: Majunath Goudar <manju.goudar@lge.com>
> 
> Suspend scenario in case of ohci-ep93xx glue was not
> properly handled as it was not suspending generic part
> of ohci controller. Alan Stern suggested, properly handle
> ohci-ep93xx suspend scenario.
> 
> Calling explicitly the ohci_suspend() routine in
> ohci_hcd_ep93xx_drv_suspend() will ensure proper handling of
> suspend scenario.

This patch isn't needed any more.  H Hartley Sweeten has just submitted 
a patch to remove ohci-ep93xx entirely.

Alan Stern
