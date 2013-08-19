From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Mon, 19 Aug 2013 16:22:53 +0200
Subject: [PATCH v12 10/11] ARM: dts: add AM33XX EDMA support
In-Reply-To: <1371762407-24544-11-git-send-email-joelagnel@ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
 <1371762407-24544-11-git-send-email-joelagnel@ti.com>
Message-ID: <52122A3D.8040305@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2013 11:06 PM, Joel A Fernandes wrote:
> From: Matt Porter <mdp@ti.com>
> 
> Adds AM33XX EDMA support to the am33xx.dtsi as documented in
> Documentation/devicetree/bindings/dma/ti-edma.txt
> 
> Joel: Drop DT entries that are non-hardware-description for now as discussed in [1]
> 
> [1] https://patchwork.kernel.org/patch/2226761/
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> Signed-off-by: Joel A Fernandes <joelagnel@ti.com>

I've been browsing my lkml folders and I haven't seen any later version
of this patch. It seems that other patches from this series have been
applied. I don't see this patch in linux-next as of Friday. Any reason
why this has not been applied yet?

Sebastian
