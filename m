From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 31 Aug 2017 18:04:30 +0200
Subject: [PATCH v2] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <20170828105405.19552-1-laurentiu.tudor@nxp.com>
References: <20170828105405.19552-1-laurentiu.tudor@nxp.com>
Message-ID: <20170831160430.GB11200@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 28, 2017 at 01:54:05PM +0300, laurentiu.tudor at nxp.com wrote:
> From: Stuart Yoder <stuart.yoder@nxp.com>
> 
> Move the source files out of staging into their final locations:
>   -include files in drivers/staging/fsl-mc/include go to include/linux/fsl
>   -irq-gic-v3-its-fsl-mc-msi.c goes to drivers/irqchip
>   -source in drivers/staging/fsl-mc/bus goes to drivers/bus/fsl-mc
>   -README.txt, providing and overview of DPAA goes to
>    Documentation/dpaa2/overview.txt
> 
> Update or delete other remaining staging files-- Makefile, Kconfig, TODO.
> Update dpaa2_eth and dpio staging drivers.
> 
> Signed-off-by: Stuart Yoder <stuyoder@gmail.com>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> [Laurentiu: rebased, add dpaa2_eth and dpio #include updates]
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

This is going to have to wait until I get a chunk of time to do the
review.  Probably after 4.13-final is out.

thanks,

greg k-h
