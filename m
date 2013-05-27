From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 27 May 2013 10:55:21 -0400 (EDT)
Subject: [RFC V7 PATCH 2/3] USB: OHCI: Generic changes to make ohci-pci
 a separate driver
In-Reply-To: <1369657550-24101-3-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1305271055020.21231-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 May 2013, Manjunath Goudar wrote:

> Note that this changes is part of separating the ohci pci host controller
> driver from ohci-hcd host code.
> This contains :
>      -Moved sb800_prefetch() function from ohci-pci.c to pci-quirks.c file
>       and EXPORTed, this is part of the effort to move the ohci pci related
>       code to generic pci code.
>      -Passed "device" argument instead  of "ohci_hcd" in sb800_prefetch()
>       function to avoid extra include file in pci-quirks.c.
> 
> V2:
>      -Passed "device" argment instead of "pci_dev", then we use to_pci_dev()
>       to get the "pci_dev" structure.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
