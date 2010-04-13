From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 13 Apr 2010 17:22:47 +0200
Subject: [PATCH 1/2] DMAENGINE: Support for ST-Ericssons DMA40 block v3
In-Reply-To: <1269956022-31299-1-git-send-email-linus.walleij@stericsson.com>
References: <1269956022-31299-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <z2g63386a3d1004130822jd41faedcp4929aa2d389687d5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/3/30 Linus Walleij <linus.walleij@stericsson.com>:

> This is a straightforward driver for the ST-Ericsson DMA40 DMA
> controller found in U8500, implemented akin to the existing
> COH 901 318 driver.

Dan, if this driver is fine can it be put into the async_tx tree?
Andrew already has it in his tree but it shouldn't cause any problems
in my limited experience.

Linus Walleij
