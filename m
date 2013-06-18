From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 18 Jun 2013 14:23:01 -0400 (EDT)
Subject: [PATCH V2 4/6] USB: OHCI: make ohci-spear a separate driver
In-Reply-To: <1371052442-14541-5-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1306181421520.1157-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Jun 2013, Manjunath Goudar wrote:

> Separate the ST OHCI SPEAr host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM;
> it would be nice to have in 3.11.
> 
> V2:
>  -ohci_setup() removed because it is called in .reset member
>   of the ohci_hc_driver structure.
>  -debugging stuff isn't needed any more that's what removed.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
