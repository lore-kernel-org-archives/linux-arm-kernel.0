From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 12 Jan 2011 13:42:37 +0100
Subject: [PATCH v2] ARM: Change misleading warning when
	CONFIG_CMDLINE_FORCE is used
In-Reply-To: <20110112093246.GA25718@pengutronix.de>
References: <1294789556-3870-1-git-send-email-holler@ahsoftware.de>
	<20110112081147.GA24920@pengutronix.de>
	<20110112091716.GU11039@n2100.arm.linux.org.uk>
	<20110112093246.GA25718@pengutronix.de>
Message-ID: <4D2DA1BD.2040601@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Am 12.01.2011 10:32, schrieb Uwe Kleine-K?nig:
> Hello Russell,ah, I thought the effect of CONFIG_CMDLINE_FORCE would be its inverse.
> And ok, this is probably about broken boot loaders that I'm just not
> used to.
>    

The real intention of CONFIG_CMD_FORCE was hotplug. Take a device with a 
bootloader wich loads the kernel from the first partition of a 
changeable media (e.g. usb-hd).
Without that option you would have to use the same command line for all 
medias.

But I find it also very handy for rescue-kernels and such.

Regards,

Alexander
