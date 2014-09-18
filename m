From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 18 Sep 2014 08:35:10 -0700
Subject: [PATCHv2] watchdog: imx2_wdt: add restart handler support
In-Reply-To: <1410506676-24205-1-git-send-email-jingchang.lu@freescale.com>
References: <1410506676-24205-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <20140918153510.GC11881@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 03:24:36PM +0800, Jingchang Lu wrote:
>   Register the watchdog as the system restart function
> to the new introducing kernel restart call chain in the
> driver instead of providing the restart in machine desc.
>   This restart handler function is from the mxc_restart()
> in arch/arm/mach-imx/system.c
> 
> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>

Looks good to me.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter
