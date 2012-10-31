From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 31 Oct 2012 15:10:28 +0000
Subject: [PATCH v2 4/5] irqchip: Move ARM VIC to drivers/irqchip
In-Reply-To: <1351695517-5636-5-git-send-email-robherring2@gmail.com>
References: <1351695517-5636-1-git-send-email-robherring2@gmail.com>
 <1351695517-5636-5-git-send-email-robherring2@gmail.com>
Message-ID: <20121031151028.GO21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 09:58:36AM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Now that we have drivers/irqchip, move VIC irqchip to drivers/irqchip.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/arm/common/Kconfig                            |   15 ---------------
>  arch/arm/common/Makefile                           |    1 -
>  drivers/irqchip/Kconfig                            |   15 +++++++++++++++
>  drivers/irqchip/Makefile                           |    1 +
>  arch/arm/common/vic.c => drivers/irqchip/irq-vic.c |    0
>  drivers/irqchip/irqchip.c                          |   14 ++++++++++++++
>  drivers/irqchip/irqchip.h                          |    1 +
>  7 files changed, 31 insertions(+), 16 deletions(-)
>  rename arch/arm/common/vic.c => drivers/irqchip/irq-vic.c (100%)

Same problem here...
