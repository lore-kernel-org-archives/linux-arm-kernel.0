From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed, 23 Mar 2016 12:19:30 +0100
Subject: [PATCH 2/2 v5] irqchip/Layerscape: Add SCFG MSI controller support
In-Reply-To: <56F27914.3080908@arm.com>
References: <1457321782-3245-1-git-send-email-Minghuan.Lian@nxp.com>
 <7239962.9Fyo0vfqsc@ws-stein> <56F27914.3080908@arm.com>
Message-ID: <1547622.IrIylJTC5Q@ws-stein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 March 2016 11:08:04, Marc Zyngier wrote:
> > Using an intel e1000e card which uses 3 MSIs. But the IRQ numbers are a bit strange though:
> >> grep eth3 /proc/interrupts
> >>
> >>  63:         49          0       MSI 134742016 Edge      eth3-rx-0
> >>  64:          3          0       MSI 134742017 Edge      eth3-tx-0
> >>  65:          4          0       MSI 134742018 Edge      eth3
> 
> This is a virtual interrupt number (despite being displayed as a hwirq),
> computed from the PCI requester ID and the MSI index. You shouldn't
> infer anything from it.

Why show it anyway then if you can't infer anything?

Best regards,
Alexander
