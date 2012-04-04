From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 4 Apr 2012 12:07:01 -0400 (EDT)
Subject: [PATCH v3 06/12] USB: ohci-at91: change maximum number of ports
In-Reply-To: <1333467033-29124-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <Pine.LNX.4.44L0.1204041205190.1543-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Apr 2012, Nicolas Ferre wrote:

> Change number of ports to 3 for newer SoCs. Modify pdata structure
> and ohci-at91 code that was dealing with ports information and check
> of port indexes.
> Several coding style errors have been addresses as the patch was touching
> affected lines of code and was producing errors while run through
> checkpatch.pl.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
> v3: - address all style errors in this patch (to prevent carrying them)
>     - merge following patch about one-line ifs
> 
> v2: - use of AT91_MAX_USBH_PORTS instead of ARRAY_SIZE()
>     - modify wIndex ohci_at91_hub_control() for simpler code

This is better.  For this patch and the other ones in this series
affecting ohci-at91 and ehci-at91:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
