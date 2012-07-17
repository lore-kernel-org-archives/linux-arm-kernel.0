From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 16 Jul 2012 17:40:57 -0700
Subject: [PATCH 00/12] chipidea/imx: add otg support and some bug fix
In-Reply-To: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
References: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120717004057.GA25562@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2012 at 03:01:40PM +0800, Richard Zhao wrote:
> The patch set is tested on imx6q_sabrelite board.
> 
> The patch can also be found at
> https://github.com/riczhao/kernel-imx/commits/topics/usb-driver
> 
> For test which merged platform patches:
> https://github.com/riczhao/kernel-imx/commits/topics/usb-test
> 
> It's better apply after patch I sent out:
> usb: chipidea: cleanup dma_pool if udc_start() fails

I need acks from Alexander before I can accept any of these.

thanks,

greg k-h
