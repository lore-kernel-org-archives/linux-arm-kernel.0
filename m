From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 16:59:34 -0500
Subject: [PATCH v2 1/5] mtd: spi-nor: cadence-quadspi: Add TI 66AK2G SoC
 specific compatible
In-Reply-To: <20170816045053.15492-2-vigneshr@ti.com>
References: <20170816045053.15492-1-vigneshr@ti.com>
 <20170816045053.15492-2-vigneshr@ti.com>
Message-ID: <20170817215934.tfmlp5thmv4gcylp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 16, 2017 at 10:20:49AM +0530, Vignesh R wrote:
> Update binding documentation to add a new compatible for TI 66AK2G SoC,
> to handle TI SoC specific quirks in the driver.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/mtd/cadence-quadspi.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
