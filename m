From: jdzheng@broadcom.com (Jiandong Zheng)
Date: Thu, 2 Aug 2012 10:03:45 -0700
Subject: [PATCH] mtd: use %*ph[CN] to dump small buffers
In-Reply-To: <1343912807-29355-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1343912807-29355-1-git-send-email-andriy.shevchenko@linux.intel.com>
Message-ID: <501AB2F1.6060101@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/2/2012 6:06 AM, Andy Shevchenko wrote:
> There is new format specified that helps to dump small buffers. It makes the
> code simplier and nicer.
>
> Signed-off-by: Andy Shevchenko<andriy.shevchenko@linux.intel.com>
> Cc: David Woodhouse<dwmw2@infradead.org>
> Cc: Jiandong Zheng<jdzheng@broadcom.com>
> Cc: Ben Dooks<ben-linux@fluff.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> ---

>   drivers/mtd/nand/bcm_umi_bch.c    |   17 ++++-------------
>
Acked-by: Jiandong Zheng <jdzheng@broadcom.com>
