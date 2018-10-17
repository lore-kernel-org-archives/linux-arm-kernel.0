From: robh@kernel.org (Rob Herring)
Date: Wed, 17 Oct 2018 14:33:46 -0500
Subject: [PATCH 06/11] dt-bindings: spi/spi-pxa2xx: Add spi-slave property
In-Reply-To: <20181010170936.316862-7-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-7-lkundrak@v3.sk>
Message-ID: <20181017193346.GB8853@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 07:09:31PM +0200, Lubomir Rintel wrote:
> This is used to indicate that the chip attached to this controller is a SPI
> master.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  Documentation/devicetree/bindings/spi/spi-pxa2xx.txt | 1 +
>  1 file changed, 1 insertion(+)

This could be rolled into patch 1. Either way,

Reviewed-by: Rob Herring <robh@kernel.org>
