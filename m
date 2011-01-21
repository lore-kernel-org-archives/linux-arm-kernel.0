From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 21 Jan 2011 13:23:18 +0200
Subject: [PATCH] MTD: atmel_nand: Add DMA support to access Nandflash
In-Reply-To: <1295332565-25610-2-git-send-email-hong.xu@atmel.com>
References: <hong.xu@atmel.com>
	<1295332565-25610-2-git-send-email-hong.xu@atmel.com>
Message-ID: <1295608998.3186.3.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-01-18 at 14:36 +0800, Hong Xu wrote:
> Some SAM9 chips have the ability to perform DMA between CPU and SMC controller.
> This patch adds DMA support for SAM9RL, SAM9G45, SSAM9G46,AM9M10, SAM9M11.
> 
> Signed-off-by: Hong Xu <hong.xu@atmel.com>

Pushed to l2-mtd-2.6.git, thanks.

-- 
Best Regards,
Artem Bityutskiy (???????? ?????)
