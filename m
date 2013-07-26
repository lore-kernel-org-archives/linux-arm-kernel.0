From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 26 Jul 2013 15:01:25 -0400 (EDT)
Subject: [PATCH V3 2/2] USB: OHCI: make ohci-pxa27x a separate driver
In-Reply-To: <1374850157-5854-3-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1307261459060.1028-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Jul 2013, Manjunath Goudar wrote:

> Separate the  OHCI pxa27x/pxa3xx host controller driver from
> ohci-hcd host code so that it can be built as a separate driver
> module. This work is part of enabling multi-platform kernels on
> ARM.
> 
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg KH <greg@kroah.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-usb at vger.kernel.org
> 
> V2:
>  -Changed ohci_hcd and pxa27x_ohci struct variable names.
>     1 ohci_hcd struct variable name is ohci.
>     2 pxa27x_ohci struct variable name is pxa_ohci.
> 
> V3:
>  -Rewrite the macro definition of to_pxa27x_ohci.
>  -clk_put() function has been called before usb_put_hcd().

Acked-by: Alan Stern <stern@rowland.harvard.edu>
