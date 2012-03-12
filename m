From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Mar 2012 08:46:28 +0000
Subject: [PATCH v7 1/4] USB: OHCI-HCD: Rename ohci-pnx4008 to ohci-nxp
In-Reply-To: <1331463219-23293-2-git-send-email-stigge@antcom.de>
References: <1331463219-23293-1-git-send-email-stigge@antcom.de>
 <1331463219-23293-2-git-send-email-stigge@antcom.de>
Message-ID: <201203120846.29070.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 11 March 2012, Roland Stigge wrote:
> Since this driver is compatible with several NXP devices, the driver is renamed
> accordingly. Please combine with the following patch which also changes the
> respective symbol names.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 

Hi Roland,

As a general comment, it's helpful to use the "-M" flag to git-format-patch
whenever you rename files, because that makes it obvious whether you have
changed anything in the file or not.

> --- /dev/null
> +++ linux-2.6/drivers/usb/host/ohci-nxp.c
> @@ -0,0 +1,453 @@
> +/*
> + * drivers/usb/host/ohci-pnx4008.c
> + *
> + * driver for Philips PNX4008 USB Host
> + *

I think your second patch does not change this comment and probably should.

Just remove the file name from the comment because that one is generally
not helpful.

	Arnd
