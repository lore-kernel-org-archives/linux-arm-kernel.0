From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 17 Jan 2013 10:16:43 -0500 (EST)
Subject: [PATCH v7 01/22] mfd: omap-usb-host: Consolidate OMAP USB-HS
 platform data
In-Reply-To: <1358422231-24736-2-git-send-email-rogerq@ti.com>
Message-ID: <Pine.LNX.4.44L0.1301171016090.1339-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Jan 2013, Roger Quadros wrote:

> Let's have a single platform data structure for the OMAP's High-Speed
> USB host subsystem instead of having 3 separate ones i.e. one for
> board data, one for USB Host (UHH) module and one for USB-TLL module.
> 
> This makes the code much simpler and avoids creating multiple copies of
> platform data.
> 
> CC: Alan Stern <stern@rowland.harvard.edu>
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

For the ehci-omap.c part:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
