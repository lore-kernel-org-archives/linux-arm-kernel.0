From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 29 Jul 2013 12:34:43 +0530
Subject: [PATCH v2] ARM: EDMA: Fix clearing of unused list for DT DMA
 resources
In-Reply-To: <51F4589E.5070108@ti.com>
References: <1374515989-7391-1-git-send-email-joelf@ti.com>
 <51F4589E.5070108@ti.com>
Message-ID: <51F6140B.3070600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 28 July 2013 05:02 AM, Joel Fernandes wrote:
> Hi Tony or Sekhar,
> 
> If this patch looks ok, could you pick it up for -rc cycle?
> 
> It fixes DMA breakages after the merge window for devices for which DMA
> resources are being populated in device tree instead pdev.

But which DT-enabled platform in kernel is using EDMA? A grep for edma
over arch/arm/boot/dts/* brings up nothing.

Does this really have to go into the -rc cycle or can it wait till v3.12?

Thanks,
Sekhar
