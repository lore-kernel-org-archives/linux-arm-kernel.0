From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 22 Aug 2017 18:39:47 -0700
Subject: [PATCH] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <20170819171812.21902-1-laurentiu.tudor@nxp.com>
References: <20170819171812.21902-1-laurentiu.tudor@nxp.com>
Message-ID: <20170823013947.GB10615@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 19, 2017 at 08:18:12PM +0300, laurentiu.tudor at nxp.com wrote:
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

Really?  You all have fixed all of the previous issues found?  Is it
time for another real review?  If so, please ask for it.

thanks,

greg k-h
