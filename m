From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 30 Jun 2016 16:30:17 +0000
Subject: [PATCH 4/6] irqchip: add irqchip driver for nuc900
In-Reply-To: <1466851042-22239-5-git-send-email-vw@iommu.org>
References: <1466851042-22239-1-git-send-email-vw@iommu.org>
 <1466851042-22239-5-git-send-email-vw@iommu.org>
Message-ID: <20160630163017.GF9922@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wan,

On Sat, Jun 25, 2016 at 06:37:20PM +0800, Wan Zongshun wrote:
> This patch is to add irqchip driver support for nuc900 plat,
> current this driver only supports nuc970 SoC.
> 
> Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
> ---
>  arch/arm/mach-w90x900/include/mach/irqs.h          |  69 ++++++++++++++
>  .../mach-w90x900/include/mach/nuc970-regs-aic.h    |  53 +++++++++++
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-nuc900.c                       | 104 +++++++++++++++++++++
>  4 files changed, 227 insertions(+)
>  create mode 100644 arch/arm/mach-w90x900/include/mach/nuc970-regs-aic.h
>  create mode 100644 drivers/irqchip/irq-nuc900.c

When you resend after addressing Arnd's comments, please include the
irqchip maintainers in the cc.

thx,

Jason.
