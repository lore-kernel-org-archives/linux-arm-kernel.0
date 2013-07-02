From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 2 Jul 2013 11:26:11 -0400 (EDT)
Subject: [PATCH V2] USB: OHCI: make ohci-nxp a separate driver
In-Reply-To: <1372765832-18054-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1307021125480.1086-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Jul 2013, Manjunath Goudar wrote:

> Separate the OHCI NXP host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM.
> 
> Many place function name and struct name started with usb,
> current scenario replaced usb with ohci for proper naming.
> 
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg KH <greg@kroah.com>
> Cc: linux-usb at vger.kernel.org
> 
> V2:
>   - Directive check NXP_PLATFORM_DRIVER block has been removed.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
