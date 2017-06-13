From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 13 Jun 2017 12:22:15 +0200
Subject: [PATCH v7 10/10] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <20170608142855.10455-11-laurentiu.tudor@nxp.com>
References: <20170608142855.10455-1-laurentiu.tudor@nxp.com>
 <20170608142855.10455-11-laurentiu.tudor@nxp.com>
Message-ID: <20170613102215.GA5866@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 05:28:55PM +0300, laurentiu.tudor at nxp.com wrote:
> From: Stuart Yoder <stuart.yoder@nxp.com>
> 
> Move the source files out of staging into their final locations:
>   -include files in drivers/staging/fsl-mc/include go to include/linux/fsl
>   -irq-gic-v3-its-fsl-mc-msi.c goes to drivers/irqchip

Why do you have so many different .h files?  You should only need 1
"external" one, and one "internal" one, right?  Can you please work on
cleaning that up first?

thanks,

greg k-h
