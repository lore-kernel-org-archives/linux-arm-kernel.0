From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Jan 2015 11:39:43 -0800
Subject: [GIT PULL] at91: drivers for 3.20 #1
In-Reply-To: <1421341350-13936-1-git-send-email-nicolas.ferre@atmel.com>
References: <1421341350-13936-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150119193943.GH16883@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 06:02:30PM +0100, Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> This is a pull-request about AT91 drivers for 3.20. We took the USB gadget part
> with us as it depends on the Matrix syscon part. There is no dependency anyway.
> 
> Thanks, best regards,
> 
> The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d186115:
> 
>   linux 3.19-rc4 (2015-01-11 12:44:53 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-drivers
> 
> for you to fetch changes up to a5514d142e7f5cff8e02a6fb4cfcb3e301c0eb59:
> 
>   usb: gadget: at91_udc: Allocate udc instance (2015-01-15 14:53:23 +0100)
> 
> ----------------------------------------------------------------
> First batch of drivers changes for 3.20:
> - Internal AHB bus matrix (Matrix) and Static Memory Controller (SMC) are now
>   mfd/syscon drivers.
> - USB gadget full speed (at91_udc): fixes, simplification and multi-platform awareness
>   DT enhancement.
> 
> ----------------------------------------------------------------
> Boris Brezillon (12):
>       mfd: syscon: Add atmel-matrix registers definition
>       mfd: syscon: Add Atmel Matrix bus DT binding documentation
>       mfd: syscon: Add atmel-smc registers definition
>       mfd: syscon: Add Atmel SMC binding doc
>       usb: gadget: at91_udc: Fix clock names
>       usb: gadget: at91_udc: Drop uclk clock
>       usb: gadget: at91_udc: Document DT clocks and clock-names property
>       usb: gadget: at91_udc: Remove non-DT handling code
>       usb: gadget: at91_udc: Simplify probe and remove functions
>       usb: gadget: at91_udc: Rework for multi-platform kernel support
>       usb: gadget: at91_udc: Update DT binding documentation
>       usb: gadget: at91_udc: Allocate udc instance

Merged into next/drivers. Thanks.


-Olof
