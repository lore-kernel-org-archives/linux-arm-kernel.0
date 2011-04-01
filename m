From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 01 Apr 2011 15:49:48 +0300
Subject: [PATCH 1/3] MTD: atmel_nand: modify test case for using DMA
	operations
In-Reply-To: <1301473601-29570-1-git-send-email-hong.xu@atmel.com>
References: <1301473601-29570-1-git-send-email-hong.xu@atmel.com>
Message-ID: <1301662188.2789.57.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-03-30 at 16:26 +0800, Hong Xu wrote:
> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> We have better performances not using DMA for oob operations.

Would it be possible to have this comment in the code, not only in the
commit message?

> Modify size test so that it is using DMA for size greater than oobsize.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
