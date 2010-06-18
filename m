From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 18 Jun 2010 14:40:17 +0800
Subject: [PATCH 03/25] pxa3xx_nand: remove the flash info in driver
	structure
In-Reply-To: <AANLkTimbCSM3Kk-Mq3MhRDyhHAaERR-dXhtuplauB3ki@mail.gmail.com>
References: <AANLkTimbCSM3Kk-Mq3MhRDyhHAaERR-dXhtuplauB3ki@mail.gmail.com>
Message-ID: <AANLkTilnlE7hl4FKo5qRJ4PeTCuxA3Mfm13eedGPehrk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 18, 2010 at 1:33 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From 643765e6ae0f37902321f31e14b565896217dd3a Mon Sep 17 00:00:00 2001
> From: Lei Wen <leiwen@marvell.com>
> Date: Wed, 2 Jun 2010 21:54:33 +0800
> Subject: [PATCH 03/25] pxa3xx_nand: remove the flash info in driver structure
>
> After probe, all info already transfer to driver structure.
> There is no need to keep the original flash info.
> So that we could safely free the flash info in memory, which may grows
> larger when more flash is suported.
>

Some of the changes should be separated from my POV? Like the
change to oob_size, and pxa3xx_nand_resume?
