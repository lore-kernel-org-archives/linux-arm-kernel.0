From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Dec 2016 18:27:49 -0600
Subject: [PATCH v3 3/5] spi: armada-3700: Add documentation for the
 Armada 3700 SPI Controller
In-Reply-To: <20161201102719.4291-4-romain.perier@free-electrons.com>
References: <20161201102719.4291-1-romain.perier@free-electrons.com>
 <20161201102719.4291-4-romain.perier@free-electrons.com>
Message-ID: <20161206002749.qvydhdoth7rb67vk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 11:27:17AM +0100, Romain Perier wrote:
> This adds the devicetree bindings documentation for the SPI controller
> present in the Marvell Armada 3700 SoCs.
> 
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> 
> Changes in v3:
>  - Added tag "Tested-by" by Gregory
>  - Fixed commit title, as requested by Mark Brown
> 
>  .../devicetree/bindings/spi/spi-armada-3700.txt    | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-armada-3700.txt

Didn't catch the duplicate with the subject change...

Acked-by: Rob Herring <robh@kernel.org>
