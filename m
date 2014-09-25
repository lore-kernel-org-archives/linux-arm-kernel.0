From: marex@denx.de (Marek Vasut)
Date: Thu, 25 Sep 2014 12:23:54 +0200
Subject: [PATCH v8 0/2] i2c: imx: add DMA support for freescale i2c driver
In-Reply-To: <1411632689-31531-1-git-send-email-yao.yuan@freescale.com>
References: <1411632689-31531-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <201409251223.54218.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 25, 2014 at 10:11:27 AM, Yuan Yao wrote:
> Changed in v8:
> - some minor fixes for coding style.
> - unsetting I2CR_DMAEN immediatelly when failed in DMA mode.

Brief skim over the patch doesn't show any dangling problems.

Reviewed-by: Marek Vasut <marex@denx.de>

btw. the U-Boot output is completely irrelevant, it only points out you use 
outdated version, so please keep only the relevant output. Also, I would 
recommend you to trim the responses to patches with [...] so one doesn't have to 
scroll through a wall of old text, but can easily find the relevant portions.

Best regards,
Marek Vasut
