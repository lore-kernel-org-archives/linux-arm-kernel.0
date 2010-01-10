From: ben@fluff.org (Ben Dooks)
Date: Sun, 10 Jan 2010 13:15:29 +0000
Subject: [PATCH v2 0/2] I2C driver support for Nomadik/Ux500
In-Reply-To: <cover.1262944133.git.srinidhi.kasagar@stericsson.com>
References: <cover.1262944133.git.srinidhi.kasagar@stericsson.com>
Message-ID: <20100110131529.GE1224@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2010 at 04:00:24PM +0530, srinidhi kasagar wrote:
> This is the v2 version of the patch which adds support for the
> ST-Ericsson's I2C block found in U8500/Nomadik 8815 platforms.
> 
> ---
> Changelog v1->v2
> - file rename from i2c-nmk.c to i2c-nomadik.c (Jean Delvare)
> - remove the unnecessary return statement (Jean Delvare)
> - kernel doc style comment fix & other fixes (Linus Walleij)
> - Added support for 400 KHz.
> 
> - patch 1/2 : targets plat-nomadik folder
> - patch v2 2/2 : fixes the above comments.
> ---
> 
> srinidhi kasagar (2):
>   ARM nomadik: add platform specific i2c configuration structures
>   i2c: Add support for Ux500/Nomadik I2C controller
> 
>  arch/arm/plat-nomadik/include/plat/i2c.h |   37 ++
>  drivers/i2c/busses/Kconfig               |    7 +
>  drivers/i2c/busses/Makefile              |    1 +
>  drivers/i2c/busses/i2c-nomadik.c         |  980 ++++++++++++++++++++++++++++++
>  4 files changed, 1025 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-nomadik/include/plat/i2c.h
>  create mode 100644 drivers/i2c/busses/i2c-nomadik.c

I'll get round to reviewing the new patches in the next day or two.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
