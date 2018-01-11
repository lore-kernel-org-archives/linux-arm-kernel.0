From: robh@kernel.org (Rob Herring)
Date: Thu, 11 Jan 2018 16:23:59 -0600
Subject: [PATCH v3 1/7] dt-bindings: mtd: document new nand-rb property
In-Reply-To: <20180109103637.23798-2-miquel.raynal@free-electrons.com>
References: <20180109103637.23798-1-miquel.raynal@free-electrons.com>
 <20180109103637.23798-2-miquel.raynal@free-electrons.com>
Message-ID: <20180111222359.aj2yyhduniw4egik@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 11:36:31AM +0100, Miquel Raynal wrote:
> There are already an atmel,rb and an allwinner,rb properties, let's not
> make other ones and instead use a generic term: nand-rb to define NAND
> chips Ready/Busy lines.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/mtd/nand.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
