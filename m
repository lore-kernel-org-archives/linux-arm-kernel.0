From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 20 Feb 2013 11:33:19 -0500 (EST)
Subject: [V2 7/8] USB: EHCI: make ehci-w90X900 a separate driver
In-Reply-To: <1360923853-7875-8-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1302201132440.1671-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Feb 2013, Manjunath Goudar wrote:

> Separate the Nuvoton On-Chip host controller driver
> from ehci-hcd host code into its own static driver module.

> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -238,7 +238,7 @@ config USB_EHCI_MV
>  	  only be EHCI host. OTG is controller that can switch to host mode.
>  
>  config USB_W90X900_EHCI
> -	bool "W90X900(W90P910) EHCI support"
> +	 tristate "W90X900(W90P910) EHCI support"

Whitespace error.  You inserted an extra space character.

Alan Stern
