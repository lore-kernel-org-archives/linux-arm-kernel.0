From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 04 Apr 2014 11:02:05 -0700
Subject: [PATCH] watchdog: sunxi: Fix compilation with C=2
In-Reply-To: <1396632265-16124-1-git-send-email-emilio@elopez.com.ar>
References: <1396632265-16124-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <533EF39D.6090907@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2014 10:24 AM, Emilio L?pez wrote:
> When compiling sunxi_defconfig while using C=2, the following error
> causes the compilation to fail:
>
>      drivers/watchdog/sunxi_wdt.c:60:15: error: constant 0b0001 is not a valid number
>
> Fix it by using hex notation instead of the non-standard binary one
>
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
