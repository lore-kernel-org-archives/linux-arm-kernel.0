From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 26 Nov 2012 06:39:36 -0800
Subject: [PATCH 01/27] usb: gadget: mv_udc: use udc_start and udc_stop
 functions
In-Reply-To: <1353905020-29372-2-git-send-email-xiechao.mail@gmail.com>
References: <1353905020-29372-1-git-send-email-xiechao.mail@gmail.com>
 <1353905020-29372-2-git-send-email-xiechao.mail@gmail.com>
Message-ID: <20121126143936.GB6322@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 25, 2012 at 11:43:14PM -0500, Chao Xie wrote:
> From: Chao Xie <chao.xie@marvell.com>
> 
> This patches converts the driver into the new style start/stop
> interface. As a result the driver no longer uses the static
> global the_conroller variable.
> 
> Signed-off-by: Chao Xie <xiechao.mail@gmail.com>

How come your signed-off-by address does not match your "From:" address
on the patch?  The marvell.com address should be both here, right?

Please fix that.

thanks,

greg k-h
