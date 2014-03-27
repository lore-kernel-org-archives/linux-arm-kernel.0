From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 27 Mar 2014 09:18:14 +0100
Subject: [PATCH v8 0/3] ARM: sun7i/sun6i: irqchip: Irqchip driver for NMI
 controller
In-Reply-To: <1395870648-17240-1-git-send-email-carlo@caione.org>
References: <1395870648-17240-1-git-send-email-carlo@caione.org>
Message-ID: <20140327081814.GG6120@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 10:50:45PM +0100, Carlo Caione wrote:
> Allwinner A20/A31 SoCs have a special interrupt controller for managing NMI.
> Three register are present to (un)mask, control and acknowledge NMI.
> These two patches add a new irqchip driver in cascade with GIC.
> 
> Changes since v1:
>         - added binding document
> 
> Changes since v2:
>         - fixed trigger type in DTS
>         - new explanations in binding documentation
>         - added support for A31 (sun6i)
> 
> Changes since v3:
>         - changed compatibles
> 
> Changes since v4:
>         - fixed binding documentation
> 
> Changes since v5:
>         - switched to handle_fasteoi_irq handler to avoid the double
>           interrupts issue
> 
> Changes since v6:
> 	- changed node name
> 	- deleted defaulted interrupt-parent property
> 
> Changes since v7:
> 	- fixed IRQ number in sun6i
> 	- NMI disabled before registering the IRQ handler

As far as I know, these patches have been merged already. Please send
followup patches to avoid having to drop merged patches.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140327/3ed73aa1/attachment.sig>
