From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Dec 2010 13:05:53 +0100
Subject: [PATCH 0/3] ux500: Add support to boot from eMMC for U5500
In-Reply-To: <1291639945-2866-1-git-send-email-per.forlin@stericsson.com>
References: <1291639945-2866-1-git-send-email-per.forlin@stericsson.com>
Message-ID: <AANLkTikWzqTXA0ZqhvCE3+Gv=U4his4crdPgGtmVurRc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/6 Per Forlin <per.forlin@stericsson.com>:

> U5500 now boots from eMMC.
> Clock tree for U5500 is not implemented.
> * Fix build issue with prcmu
> * UART and MMC clock rates are adjusted for U5500
> * Basic DMA support

I've taken these into my ux500-core tree for testing in -next.

Yours,
Linus Walleij
