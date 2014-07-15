From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 15 Jul 2014 18:55:51 +0200
Subject: [PATCH 1/3 v6] spi: s3c64xx: fix broken "cs_gpios" usage in the
 driver
In-Reply-To: <1405316506-27855-2-git-send-email-ch.naveen@samsung.com>
References: <1405316506-27855-1-git-send-email-ch.naveen@samsung.com>
 <1405316506-27855-2-git-send-email-ch.naveen@samsung.com>
Message-ID: <53C55D17.90109@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Naveen,

On 14.07.2014 07:41, Naveen Krishna Chatradhi wrote:
> Since, (3146bee spi: s3c64xx: Added provision for dedicated cs pin)
> 
> spi-s3c64xx.c driver expects
> 1. chip select gpios from "cs-gpio"(singular) under the
>    "controller-data" node of the client/slave device of the SPI.

Please work a bit more on readability of your commit messages,
especially in terms of using correct terminology to avoid unnecessary
confusion.

s/'chip select gpios'/'chip select GPIO pins'/
s/'"cs-gpio"(singular)'/'"cs-gpio" property'/
s/'client/slave device of the SPI'/'SPI device'/

More things like this follow in rest of the text below.

Otherwise I believe the code after this patch does the right thing, so:

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
