From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 28 Mar 2012 17:04:26 -0600
Subject: [PATCH V3 2/5] mtd: Add orion_nand devicetree bindings
In-Reply-To: <1332885255-8304-3-git-send-email-jm@lentin.co.uk>
References: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
 <1332885255-8304-3-git-send-email-jm@lentin.co.uk>
Message-ID: <20120328230426.CF3A43E104C@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Mar 2012 22:54:12 +0100, Jamie Lentin <jm@lentin.co.uk> wrote:
> Allow a NAND chip using the orion_nand driver to be described using devicetree.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
>  .../devicetree/bindings/mtd/orion-nand.txt         |   46 ++++++++++++++++++++
>  drivers/mtd/nand/orion_nand.c                      |   35 ++++++++++++++-
>  2 files changed, 79 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/orion-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/orion-nand.txt b/Documentation/devicetree/bindings/mtd/orion-nand.txt
> new file mode 100644
> index 0000000..22c7438
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/orion-nand.txt
> @@ -0,0 +1,46 @@
> +NAND support for Marvell Orion SoC platforms
> +
> +Required properties:
> +- compatible : "mrvl,orion-nand".
> +- reg : Base physical address of the NAND and length of memory mapped
> +	region
> +
> +Optional properties:
> +- cle :
> +- ale :
> +- bank-width :
> +- chip-delay :

Please state what data these properties contain.  :-)
