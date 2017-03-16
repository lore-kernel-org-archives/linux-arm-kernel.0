From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 16 Mar 2017 10:15:38 +0000
Subject: [PATCH v2 1/7] mfd: syscon: atmel-smc: Add new helpers to ease
 SMC regs manipulation
In-Reply-To: <1489653034-17777-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1489653034-17777-1-git-send-email-boris.brezillon@free-electrons.com>
 <1489653034-17777-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20170316101538.udmcjqh42t32z6bi@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Mar 2017, Boris Brezillon wrote:

> These new helpers + macro definitions are meant to replace the old ones
> which are unpractical to use.
> 
> Note that the macros and function prefixes have been intentionally
> changed to ATMEL_[H]SMC_XX and atmel_[h]smc_ to reflect the fact that
> this IP is also embedded in avr32 SoCs (and not only in at91 ones).
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/mfd/Kconfig                  |   4 +
>  drivers/mfd/Makefile                 |   1 +
>  drivers/mfd/atmel-smc.c              | 314 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/syscon/atmel-smc.h |  87 ++++++++++
>  4 files changed, 406 insertions(+)
>  create mode 100644 drivers/mfd/atmel-smc.c

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
  
-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
