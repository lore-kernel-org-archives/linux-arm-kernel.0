From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 23 Oct 2013 10:35:08 -0400 (EDT)
Subject: [PATCH 1/3] usb: ehci: add freescale imx28 special write register
 method
In-Reply-To: <1382517309-6730-1-git-send-email-peter.chen@freescale.com>
Message-ID: <Pine.LNX.4.44L0.1310231034470.1326-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Oct 2013, Peter Chen wrote:

> According to Freescale imx28 Errata, "ENGR119653 USB: ARM to USB
> register error issue", All USB register write operations must
> use the ARM SWP instruction. So, we implement a special ehci_write
> for imx28.
> 
> Discussion for it at below:
> http://marc.info/?l=linux-usb&m=137996395529294&w=2
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>
