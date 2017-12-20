From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Dec 2017 15:06:06 -0600
Subject: [PATCH v2 4/5] dt-bindings: mtd: remove pxa3xx NAND controller
 documentation
In-Reply-To: <20171219132942.27433-5-miquel.raynal@free-electrons.com>
References: <20171219132942.27433-1-miquel.raynal@free-electrons.com>
 <20171219132942.27433-5-miquel.raynal@free-electrons.com>
Message-ID: <20171220210606.dpx646hka2qtru5s@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 02:29:41PM +0100, Miquel Raynal wrote:
> The deprecated pxa3xx_nand.c driver does not exist anymore, it has been
> replaced by marvell_nand.c which has its own up-to-date documentation.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> ---
>  .../devicetree/bindings/mtd/pxa3xx-nand.txt        | 50 ----------------------
>  1 file changed, 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt

Reviewed-by: Rob Herring <robh@kernel.org>
