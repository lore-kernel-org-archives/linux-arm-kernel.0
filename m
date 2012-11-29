From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 29 Nov 2012 20:27:12 +0000
Subject: [PATCH v4] Introduce irqchip infrastructure
In-Reply-To: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121129202712.26D4B3E0912@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Nov 2012 23:00:51 +0100, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
> Hello,
> 
> Here is a set of patches that introduces a small irqchip
> infrastructure that allows the registration of irqchip drivers without
> having each of those drivers to expose a public API and header in
> include/linux/irqchip/, and moves a number of existing irqchip
> controller to this infrastructure.
> 
> This new version (detailed changelog below) provides a number of
> improvements: usage of a special link section to avoid the central
> registration in irqchip.{c,h} of all irqchip drivers, and addition of
> the GIC, VIC and Versatile FPGA IRQ drivers move, thanks to Rob
> Herring and Linus Walleij.

Hey Thomas,

This looks pretty darn sensible. Good job.

I've not reviewed deeply, but you can add my:

Reviewed-by: Grant Likely <grant.likely@secretlab.ca>

g.
