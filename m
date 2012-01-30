From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Mon, 30 Jan 2012 20:56:44 +0300
Subject: [PATCH v2 1/7] LPC32xx: clock.c: Missing header file
In-Reply-To: <1327939327-7799-1-git-send-email-stigge@antcom.de>
References: <1327939327-7799-1-git-send-email-stigge@antcom.de>
Message-ID: <4F26D9DC.2000008@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/30/2012 07:02 PM, Roland Stigge wrote:

> This patch fixes the compiler warnings regarding the EXPORT_SYMBOL usage

> Signed-off-by: Roland Stigge<stigge@antcom.de>

> diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
> index 1e02751..8e79313 100644
> --- a/arch/arm/mach-lpc32xx/clock.c
> +++ b/arch/arm/mach-lpc32xx/clock.c
> @@ -82,6 +82,7 @@
>    *   will also impact the individual peripheral rates.
>    */
>
> +#include<linux/module.h>

    Shouldn't <linux/export.h> be included instead nowadays?

WBR, Sergei
