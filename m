From: tony@atomide.com (Tony Lindgren)
Date: Tue, 4 Jun 2013 07:55:43 -0700
Subject: [PATCH RFC 2/3] ARM: dts: omap4 clock data
In-Reply-To: <1370327958-19776-3-git-send-email-mturquette@linaro.org>
References: <1370327958-19776-1-git-send-email-mturquette@linaro.org>
 <1370327958-19776-3-git-send-email-mturquette@linaro.org>
Message-ID: <20130604145543.GK3331@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mike Turquette <mturquette@linaro.org> [130603 23:45]:
> This is a first pass at creating a unique node for each clock in the
> OMAP4 power, reset and & clock manager (PRCM).  So far I have only
> converted mux clocks & fixed-rate clocks, which coexist with the current
> clock data in the kernel.  The rest needs to be done but better to
> publish early and often to see what others think of this approach.

> +/* FIXME need to print the address directly */
> +/*
> +#include "../../mach-omap2/prm44xx.h"
> +#include "../../mach-omap2/cm2_44xx.h"
> +#include "../../mach-omap2/cm1_44xx.h"
> +*/

I don't think you're using the above includes any longer
in this file?

Regards,

Tony
