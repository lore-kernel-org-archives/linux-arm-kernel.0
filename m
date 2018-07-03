From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jul 2018 16:45:54 -0600
Subject: [RFC PATCH v2 6/6] dt-bindings: spi: QuadSPI driver for Atmel
 SAMA5D2
In-Reply-To: <20180627131609.13681-7-bugalski.piotr@gmail.com>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
 <20180627131609.13681-7-bugalski.piotr@gmail.com>
Message-ID: <20180703224554.GA13754@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 03:16:09PM +0200, Piotr Bugalski wrote:
> Atmel SAMA5D2 QuadSPI driver was moved from mtd to spi subsystem,
> this change is just moving DT-binding documentation.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Piotr Bugalski <pbu@cryptera.com>
> ---
>  Documentation/devicetree/bindings/{mtd => spi}/atmel-quadspi.txt | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{mtd => spi}/atmel-quadspi.txt (100%)

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
> rename to Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> -- 
> 2.11.0
> 
