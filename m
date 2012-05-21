From: marex@denx.de (Marek Vasut)
Date: Mon, 21 May 2012 22:07:34 +0200
Subject: [PATCH v2 00/12] add imx usb driver for mx28/6x
In-Reply-To: <4FBA9BE4.7020303@grid-net.com>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <201205212141.52171.marex@denx.de> <4FBA9BE4.7020303@grid-net.com>
Message-ID: <201205212207.34978.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Subodh Nijsure,

> On 05/21/2012 12:41 PM, Marek Vasut wrote:
> > Dear Fabio Estevam,
> > 
> >> Hi Richard,
> >> 
> >> On Mon, May 21, 2012 at 6:23 AM, Richard Zhao
> >> 
> >> <richard.zhao@freescale.com>  wrote:
> >>> The work is based on  ci13xxx rework done by Alexander Shishkin.
> >>> 
> >>> Status:
> >>>   - this version only support host
> >>>   - usbotg controler works at host role
> >>> 
> >>> Changes since V1:
> >>>   - Merge the work of Marek
> >>>   - re-implement connect change notify
> >>>   - imx6q: move part of code to clk
> >>>   - imx6q: add config-on-boot gpios
> >> 
> >> Can you please also add the driver into the defconfig files?
> >> 
> >> What about the existing USB host drivers for mx27/mx31/mx35/mx25/mx35?
> >> 
> >> Is the idea to switch to drivers/usb/chipidea/host.c too?
> > 
> > I think the core is the same, it's just the ci13xxx-imx driver that'd
> > need to be written differently for these
> 
> So that means driver that you did are not going to be up streamed for
> mx28/mxs? And those interested should be tracking this patch set?

This here is definitelly going to support mx28 and I'm slowly working through 
the DT stuff to test this, all right?

We were talking about imx.{xz|x,y is [0-9a-z]} \ imx.{23,28,6q}

> 
> -Subodh

Best regards,
Marek Vasut
