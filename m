From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 5 Nov 2012 08:49:34 +0100
Subject: [PATCH 1/1] usb: at91_udc: fix typo on vubs pullup valid check
In-Reply-To: <1352101183-20606-1-git-send-email-plagnioj@jcrosoft.com>
References: <1352101183-20606-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20121105074934.GB2034@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 08:39:43AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> if the gpio is not valid complain
> 
> since 3285e0ec088febc5a88f57ddd78385a7da71476c
> ARM: at91/udc: use gpio_is_valid to check the gpio
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: linux-usb at vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Hi Greg,
> 
> 	this is broken since 3.2 can we have on the stable too

Sure, but you should be sending gadget patches to Felipe, not me, as
he's in charge of that tree.  So I suggest you resend this, cc: Felipe
and add the proper stable tree marking to the Cc: area of the
signed-off-by: part of the patch, like the file
Documentation/stable_kernel_rules.txt describes to do.  That way it will
be picked up automatically for the stable releases when it gets in to
Linus's tree.

thanks,

greg k-h
