From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Sep 2010 12:06:32 +0100
Subject: [PATCH] ux500: add CPU hotplug support
In-Reply-To: <1284375698-1824-1-git-send-email-sundar.iyer@stericsson.com>
References: <1284375698-1824-1-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <20100913110632.GC30787@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 13, 2010 at 04:31:38PM +0530, Sundar Iyer wrote:
> diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
> index 438ef16..ade2e17 100644
> --- a/arch/arm/mach-ux500/platsmp.c
> +++ b/arch/arm/mach-ux500/platsmp.c
> @@ -26,7 +26,7 @@
>   * control for which core is the next to come out of the secondary
>   * boot "holding pen"
>   */
> -volatile int __cpuinitdata pen_release = -1;
> +volatile int pen_release = -1;

This looks like an unnecessary change.
