From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 4 Jul 2012 18:43:20 -0300
Subject: [PATCH 8/8] mmc: spi: Add DMA support into SPI driver
In-Reply-To: <201207042340.55301.marex@denx.de>
References: <1340958180-2291-1-git-send-email-marex@denx.de>
 <1340958180-2291-8-git-send-email-marex@denx.de>
 <CAOMZO5AN852f3Awv0UG+ApsgMC-x5ByQrLkUC5SkOnty5T0EMA@mail.gmail.com>
 <201207042340.55301.marex@denx.de>
Message-ID: <CAOMZO5APBLyvYFqKonkjOwXgHcDw7x6fNL9o775F4xCwvXCjOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 4, 2012 at 6:40 PM, Marek Vasut <marex@denx.de> wrote:

>> Shouldn't you check for dmares < 0 here too?
>
> Yes. What about the rest of the patches? Are they applicable?

They look fine for me. Let's see if we have more comments.
