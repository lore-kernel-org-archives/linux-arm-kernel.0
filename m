From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 26 May 2015 14:08:53 +0200
Subject: [PATCH 2/3] spi: orion: Fix extended baud rates for each Armada
 SoCs
In-Reply-To: <1432633484-18758-3-git-send-email-gregory.clement@free-electrons.com>
References: <1432633484-18758-1-git-send-email-gregory.clement@free-electrons.com>
 <1432633484-18758-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150526120853.GB28523@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> --- a/Documentation/devicetree/bindings/spi/spi-orion.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-orion.txt
> @@ -1,7 +1,13 @@
>  Marvell Orion SPI device
>  
>  Required properties:
> -- compatible : should be "marvell,orion-spi" or "marvell,armada-370-spi".
> +- compatible : should be on of the following:
> +    - "marvell,orion-spi" for the Orion, mv78x00, Kirkwood and Dove SoCs
> +    - "marvell,armada-370-spi", for the Armada 370 SoCs
> +    - "marvell,armada-375-spi", for the Armada 375 SoCs
> +    - "marvell,armada-380-spi", for the Armada 38x SoCs
> +    - "marvell,armada-390-spi", for the Armada 38x SoCs

Hi Gregory

Is that a typ0?

   Andrew
