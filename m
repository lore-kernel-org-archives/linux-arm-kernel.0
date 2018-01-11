From: robh@kernel.org (Rob Herring)
Date: Thu, 11 Jan 2018 16:25:50 -0600
Subject: [PATCH v3 2/7] dt-bindings: mtd: add Marvell NAND controller
 documentation
In-Reply-To: <20180109103637.23798-3-miquel.raynal@free-electrons.com>
References: <20180109103637.23798-1-miquel.raynal@free-electrons.com>
 <20180109103637.23798-3-miquel.raynal@free-electrons.com>
Message-ID: <20180111222550.nxus25nqoyvhq22r@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 11:36:32AM +0100, Miquel Raynal wrote:
> Document the legacy and the new bindings for Marvell NAND controller.
> 
> The pxa3xx_nand.c driver does only support legacy bindings, which are
> incomplete and inaccurate. A rework of this controller (called
> marvell_nand.c) does support both.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> ---
>  .../devicetree/bindings/mtd/marvell-nand.txt       | 123 +++++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt

Reviewed-by: Rob Herring <robh@kernel.org>
