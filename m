From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Mar 2012 08:17:12 +0000
Subject: [PATCH V3 5/5] mtd: Move fdt partition documentation to a
 seperate file
In-Reply-To: <1332885255-8304-6-git-send-email-jm@lentin.co.uk>
References: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
 <1332885255-8304-6-git-send-email-jm@lentin.co.uk>
Message-ID: <201203280817.12652.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 March 2012, Jamie Lentin wrote:
> 
> Partitions are described in the same way for all mtd devices when using
> devicetree, move the documentation to a separate file and add references
> to it.
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> ---
>  .../devicetree/bindings/mtd/arm-versatile.txt      |    4 +-
>  .../devicetree/bindings/mtd/atmel-dataflash.txt    |    3 ++
>  .../devicetree/bindings/mtd/fsl-upm-nand.txt       |    4 ++
>  .../devicetree/bindings/mtd/gpio-control-nand.txt  |    3 ++
>  .../devicetree/bindings/mtd/mtd-physmap.txt        |   23 +-----------
>  .../devicetree/bindings/mtd/orion-nand.txt         |    3 ++
>  .../devicetree/bindings/mtd/partition.txt          |   38 ++++++++++++++++++++
>  7 files changed, 55 insertions(+), 23 deletions(-)
