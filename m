From: greg@kroah.com (Greg KH)
Date: Wed, 5 Sep 2012 13:27:49 -0700
Subject: [PATCH v3 20/23] serial: omap: fix software flow control
In-Reply-To: <1345717983-18179-21-git-send-email-balbi@ti.com>
References: <1345717983-18179-1-git-send-email-balbi@ti.com>
 <1345717983-18179-21-git-send-email-balbi@ti.com>
Message-ID: <20120905202749.GA2451@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 01:33:00PM +0300, Felipe Balbi wrote:
> From: Vikram Pandita <vikram.pandita@ti.com>
> 
> Software flow control register bits were not defined correctly.
> 
> Also clarify the IXON and IXOFF logic to reflect what userspace wants.
> 
> Cc: stable at vger.kernel.org
> Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---

If this is a stable patch, should it be pulled out and put also in for
3.6?

thanks,

greg k-h
