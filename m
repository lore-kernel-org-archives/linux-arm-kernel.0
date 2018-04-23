From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 23 Apr 2018 10:37:20 +0200
Subject: [PATCH 09/15] net: irda: pxaficp_ir: remove the dmaengine compat
 need
In-Reply-To: <20180402142656.26815-10-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-10-robert.jarzmik@free.fr>
Message-ID: <20180423083720.GA25048@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2018 at 04:26:50PM +0200, Robert Jarzmik wrote:
> As the pxa architecture switched towards the dmaengine slave map, the
> old compatibility mechanism to acquire the dma requestor line number and
> priority are not needed anymore.
> 
> This patch simplifies the dma resource acquisition, using the more
> generic function dma_request_slave_channel().
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/staging/irda/drivers/pxaficp_ir.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

This file is no longer in Linus's tree :)

thanks,

greg k-h
