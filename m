From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 21 Jan 2015 10:03:55 -0500 (EST)
Subject: [PATCHv3 1/2] usb: ehci-platform: add support for multiple phys
 per controller
In-Reply-To: <1421712330-11089-2-git-send-email-arun.ramamurthy@broadcom.com>
Message-ID: <Pine.LNX.4.44L0.1501211002380.1670-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Jan 2015 arun.ramamurthy at broadcom.com wrote:

> From: Arun Ramamurthy <arunrama@broadcom.com>
> 
> Added support for cases where one controller is connected
> to multiple phys.
> 
> Signed-off-by: Arun Ramamurthy <arunrama@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> Tested-by: Scott Branden <sbranden@broadcom.com>
> ---

Right here is where you should explain how v3 of this patch is 
different from v2.

Anyway, it looks good.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Did you run it through checkpatch.pl?

Alan Stern
