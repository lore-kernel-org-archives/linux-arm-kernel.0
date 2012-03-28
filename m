From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 28 Mar 2012 10:41:55 -0400
Subject: [PATCH V3 5/5] mtd: Move fdt partition documentation to a
 seperate file
In-Reply-To: <1332885255-8304-6-git-send-email-jm@lentin.co.uk>
References: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
 <1332885255-8304-6-git-send-email-jm@lentin.co.uk>
Message-ID: <20120328144155.GA32333@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 10:54:15PM +0100, Jamie Lentin wrote:
> Partitions are described in the same way for all mtd devices when using
> devicetree, move the documentation to a separate file and add references
> to it.
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>

Acked-by: Jason Cooper <jason@lakedaemon.net>

> ---
>  .../devicetree/bindings/mtd/arm-versatile.txt      |    4 +-
>  .../devicetree/bindings/mtd/atmel-dataflash.txt    |    3 ++
>  .../devicetree/bindings/mtd/fsl-upm-nand.txt       |    4 ++
>  .../devicetree/bindings/mtd/gpio-control-nand.txt  |    3 ++
>  .../devicetree/bindings/mtd/mtd-physmap.txt        |   23 +-----------
>  .../devicetree/bindings/mtd/orion-nand.txt         |    3 ++
>  .../devicetree/bindings/mtd/partition.txt          |   38 ++++++++++++++++++++
>  7 files changed, 55 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partition.txt
