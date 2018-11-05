From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Nov 2018 15:21:48 -0600
Subject: [PATCH v3 6/6] dt-bindings: spi: QuadSPI driver for Atmel SAMA5D2
In-Reply-To: <20181105103625.9644-7-bugalski.piotr@gmail.com>
References: <20181105103625.9644-1-bugalski.piotr@gmail.com>
 <20181105103625.9644-7-bugalski.piotr@gmail.com>
Message-ID: <20181105212148.GA13045@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  5 Nov 2018 11:36:25 +0100, Piotr Bugalski wrote:
> Atmel SAMA5D2 QuadSPI driver was moved from mtd to spi subsystem,
> this change is just moving DT-binding documentation.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Piotr Bugalski <bugalski.piotr@gmail.com>
> ---
>  Documentation/devicetree/bindings/{mtd => spi}/atmel-quadspi.txt | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{mtd => spi}/atmel-quadspi.txt (100%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
