From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Jul 2012 19:29:12 +0000
Subject: [RFC PATCHv4] ARM: socfpga: initial support for Altera's SOCFPGA
 platform
In-Reply-To: <1342637233-13965-2-git-send-email-dinguyen@altera.com>
References: <1342637233-13965-1-git-send-email-dinguyen@altera.com>
 <1342637233-13965-2-git-send-email-dinguyen@altera.com>
Message-ID: <201207181929.12645.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 July 2012, dinguyen at altera.com wrote:
> --- /dev/null
> +++ b/arch/arm/mach-socfpga/common.h
> @@ -0,0 +1,23 @@
> +
> +#ifndef __MACH_SOCFPGA_COMMON_H
> +#define __MACH_SOCFPGA_COMMON_H
> +
> +extern void socfpga_init_clocks(void);
> +
> +#endif

You still have this header file which should not be there.

Everything else looks good now.

	Arnd
