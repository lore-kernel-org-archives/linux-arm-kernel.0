From: marex@denx.de (Marek Vasut)
Date: Wed, 27 Nov 2013 10:27:06 +0100
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <1385447575-23773-1-git-send-email-b32955@freescale.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
Message-ID: <201311271027.06982.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Huang Shijie,

> 1.) Why add a new framework for SPI NOR?
>   The SPI-NOR controller such as Freescale's Quadspi controller is working
>   in a different way from the SPI bus. It should knows the NOR commands to
>   find the right LUT sequence. Unfortunately, the current code can not meet
>   this requirement.

Is there any kind of documentation for this controller available? I cannot quite 
understand how this controller works and why can it not be used with our current 
infrastructure.

Best regards,
Marek Vasut
