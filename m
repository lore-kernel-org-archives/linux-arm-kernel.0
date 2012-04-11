From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 11 Apr 2012 08:23:01 -0700
Subject: [PATCH 1/1] ARM: at91: sam9rl pass the toggle bias via pdata for
 ATMEL USBA UDC
In-Reply-To: <1334152510-11031-1-git-send-email-plagnioj@jcrosoft.com>
References: <1334152510-11031-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20120411152301.GA11342@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 03:55:10PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> The toggle bias is soc specific we need to pass it via plarform_data to be able
> to have multiple soc in the same kernel.
> 
> This will also fix the modules support.
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: linux-usb at vger.kernel.org
> ---
> Hi Greg,
> 
> 	If it's ok with you we will apply it via at91 tree

Note, I'm not the USB gadget maintainer, you need Felipe's ack on this,
not mine.

greg k-h
