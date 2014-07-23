From: marex@denx.de (Marek Vasut)
Date: Wed, 23 Jul 2014 14:28:01 +0200
Subject: [PATCH v5 0/2] i2c: add DMA support for freescale i2c driver
In-Reply-To: <1406103883-3572-1-git-send-email-yao.yuan@freescale.com>
References: <1406103883-3572-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <201407231428.01278.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 23, 2014 at 10:24:41 AM, Yuan Yao wrote:
> Changed in v5:
> - add "*chan_dev = dma->chan_using->device->dev" for reduce the call time.

Did you check if the compiler generates different code ?

> - add the test logs.

[...]

Best regards,
Marek Vasut
