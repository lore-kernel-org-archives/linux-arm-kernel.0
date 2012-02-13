From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 13 Feb 2012 09:45:16 +0100
Subject: [PATCH] MTD: atmel_nand: Update driver to support Programmable
 HW ECC controller
In-Reply-To: <1329117469-23637-1-git-send-email-hong.xu@atmel.com>
References: <1329117469-23637-1-git-send-email-hong.xu@atmel.com>
Message-ID: <20120213084516.GB3378@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:17 Mon 13 Feb     , Hong Xu wrote:
> The Programmable Hardware ECC (PMECC) controller is a programmable binary
> BCH(Bose, Chaudhuri and Hocquenghem) encoder and decoder. This controller
> can be used to support both SLC and MLC NAND Flash devices. It supports to
> generate ECC to correct 2, 4, 8, 12 or 24 bits of error per sector of data.
> 
> To use this driver, the user needs to pass in the correction capability and
> the sector size.
> 
> This driver has been tested on AT91SAM9X5-EK and AT91SAM9N12-EK with JFFS2,
> YAFFS2, UBIFS and mtd-utils.
> 
> Signed-off-by: Hong Xu <hong.xu@atmel.com>
> ---
this patch must be based on the nand fixes and DT support

and pass the rom code base via resoruces

and drop the ifdef

Best Regards,
J.
