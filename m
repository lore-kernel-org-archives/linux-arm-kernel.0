From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 10 Feb 2017 18:52:53 +0100
Subject: [PATCH] usb: gadget: udc: atmel: Endpoint allocation scheme fixes
In-Reply-To: <1486748284-27597-1-git-send-email-cristian.birsan@microchip.com>
References: <1486748284-27597-1-git-send-email-cristian.birsan@microchip.com>
Message-ID: <20170210175253.GB27916@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 07:38:04PM +0200, cristian.birsan at microchip.com wrote:
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> This patch provides fixes for the following:
> 	- fifo table parameters validation against device tree values
> 	- coding style
> 	- error message display
> 	- Kconfig comments

eeek, no!  Break patches up, one thing per patch.  Otherwise they are
impossible to review and I flat out reject them.  Hopefully Felipe does
as well.

thanks,

greg k-h
