From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 12 Jun 2012 16:14:38 -0700
Subject: [PATCH v4] usb: chipidea: permit driver bindings pass phy pointer
In-Reply-To: <1339159026-15837-1-git-send-email-richard.zhao@freescale.com>
References: <1337912665-16615-3-git-send-email-richard.zhao@freescale.com>
 <1339159026-15837-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120612231438.GA6177@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 08, 2012 at 08:37:06PM +0800, Richard Zhao wrote:
> Sometimes, the driver bindings may know what phy they use.
> For example, when using device tree, the usb controller may have a
> phandler pointing to usb phy.
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Acked-by: Felipe Balbi <balbi@ti.com>
> ---
> Changes since laster version:
> - hcd transceiver renamed to phy

Ick, I see patches all over this thread, and other threads, and I have
no idea what to apply anywhere...

So, consider all chipidea patches dropped from my queue now, can you
please resend them to me, with the accumulated acks and reviewed-by
line, so that I can queue them up?

thanks,

greg k-h
