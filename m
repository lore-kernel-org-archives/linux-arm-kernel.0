From: robh@kernel.org (Rob Herring)
Date: Mon, 15 Oct 2018 14:11:12 -0500
Subject: [PATCH 2/3] dt-bindings: cadence-quadspi: Add new compatible for
 AM654 SoC
In-Reply-To: <20181003165603.2579-3-vigneshr@ti.com>
References: <20181003165603.2579-1-vigneshr@ti.com>
 <20181003165603.2579-3-vigneshr@ti.com>
Message-ID: <20181015191112.GA6923@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 3 Oct 2018 22:26:02 +0530, Vignesh R wrote:
> AM654 SoC has Cadence Octal SPI controller, which is similar to Cadence
> QSPI controller but supports Octal IO(x8 data lines) and Double Data
> Rate(DDR) mode. Add new compatible to support OSPI controller on TI's
> AM654 SoCs.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/mtd/cadence-quadspi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
