From: robh@kernel.org (Rob Herring)
Date: Fri, 18 Dec 2015 22:17:46 -0600
Subject: [PATCH v5 1/2] spi: dts: Add new device property to specifcy a
 wait time between word transmissions
In-Reply-To: <1450352427-25350-2-git-send-email-mweseloh42@gmail.com>
References: <1450352427-25350-1-git-send-email-mweseloh42@gmail.com>
 <1450352427-25350-2-git-send-email-mweseloh42@gmail.com>
Message-ID: <20151219041746.GF14936@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 12:40:26PM +0100, Marcus Weseloh wrote:
> Adds a new property "spi-word-wait-ns" to the spi-bus binding that allows
> SPI slave devices to set a wait time between the transmission of words.
> 
> Signed-off-by: Marcus Weseloh <mweseloh42@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-bus.txt | 2 ++
>  drivers/spi/spi.c                                 | 2 ++
>  include/linux/spi/spi.h                           | 2 ++
>  3 files changed, 6 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
