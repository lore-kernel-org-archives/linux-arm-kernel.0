From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 13 Jun 2012 14:17:55 -0400 (EDT)
Subject: [Patch v5 02/13] USB: move transceiver from ehci_hcd and ohci_hcd
 to hcd and rename it as phy
In-Reply-To: <1339590863-10564-3-git-send-email-richard.zhao@freescale.com>
Message-ID: <Pine.LNX.4.44L0.1206131417140.1401-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Jun 2012, Richard Zhao wrote:

>  - to decrease redundant since both ehci_hcd and ohci_hcd have the same variable
>  - it helps access phy in usb core code
>  - phy is more meaningful than transceiver
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>
