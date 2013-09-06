From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Sep 2013 10:28:54 +0100
Subject: [PATCH v2 1/2] Documentation: arm: early_ioremap/early_memremap
In-Reply-To: <1378459158-2145-2-git-send-email-leif.lindholm@linaro.org>
References: <1378459158-2145-1-git-send-email-leif.lindholm@linaro.org>
 <1378459158-2145-2-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20130906092853.GP6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 06, 2013 at 10:19:17AM +0100, Leif Lindholm wrote:
> +Any residual mappings will be overridden by subsequent kmap() calls (but do
> +use early_iounmap()).
> +
> +Specify 'early_ioremap_debug' on the kernel commandline for verbose output.
> +
> +SYNOPSIS
> +	#include <asm/io.h>

linux/io.h please.
