From: horms@verge.net.au (Simon Horman)
Date: Wed, 5 Jun 2013 15:45:45 +0900
Subject: [GIT PULL 0/4] Update for Renesas INTC External IRQ pin driver
 for v3.11
In-Reply-To: <1370406751-3852-1-git-send-email-horms+renesas@verge.net.au>
References: <1370406751-3852-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130605064545.GC14490@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ fix up subject to say GIT PULL ]

On Wed, Jun 05, 2013 at 01:32:27PM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:
> 
>   Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-intc-external-irq-for-v3.11
> 
> for you to fetch changes up to 14d064ad3881f47ae0a6f247c992652053c7f4d5:
> 
>   irqchip: Add irqchip_init dummy function (2013-05-22 21:55:41 +0900)
> 
> ----------------------------------------------------------------
> Update for Renesas INTC External IRQ pin driver for v3.11
> 
> Add runtime PM support
> Add DT binding for sense bitfield width
> Correct error handing in irqc_probe
> Add irqchip_init dummy function
> 
> ----------------------------------------------------------------
> Axel Lin (1):
>       irqchip: renesas-irqc: Fix irqc_probe error handling
> 
> Bastian Hecht (1):
>       irqchip: Add irqchip_init dummy function
> 
> Guennadi Liakhovetski (1):
>       irqchip: renesas-intc-irqpin: DT binding for sense bitfield width
> 
> Simon Horman (1):
>       irqchip: irqc: Add runtime PM support
> 
>  .../bindings/interrupt-controller/renesas,intc-irqpin.txt   | 13 +++++++++++++
>  drivers/irqchip/irq-renesas-intc-irqpin.c                   |  4 ++++
>  drivers/irqchip/irq-renesas-irqc.c                          | 12 ++++++++++--
>  include/linux/irqchip.h                                     |  4 ++++
>  4 files changed, 31 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
> 
> -- 
> 1.8.2.1
> 
