From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Mar 2017 14:13:49 -0500
Subject: [PATCH 1/2] doc: dt: mtd: add w25q64 to list of supported SPI
 flashes
In-Reply-To: <20170307215751.29266-2-fcooper@ti.com>
References: <20170307215751.29266-1-fcooper@ti.com>
 <20170307215751.29266-2-fcooper@ti.com>
Message-ID: <20170315191349.mxh2ahnhn2uhyvm4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 07, 2017 at 03:57:50PM -0600, Franklin S Cooper Jr wrote:
> From: Sekhar Nori <nsekhar@ti.com>
> 
> W25Q64 is found on TI's AM335x ICEv2 board. Add it to list
> for supported SPI flash devices. This flash can be identified
> using JEDEC READ ID opcode.
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
