From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 21 Sep 2014 09:32:26 -0700
Subject: [PATCH v2 1/2] watchdog: sunxi: support parameterized compatible
 strings
In-Reply-To: <1411315519-26257-2-git-send-email-wens@csie.org>
References: <1411315519-26257-1-git-send-email-wens@csie.org>
 <1411315519-26257-2-git-send-email-wens@csie.org>
Message-ID: <541EFD9A.2000406@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21/2014 09:05 AM, Chen-Yu Tsai wrote:
> This patch adds support for hardware parameters tied to compatible
> strings, so similar hardware can reuse the driver.
>
> This will be used to support the newer watchdog found in A31 and
> later SoCs. Differences in the new hardware include separate
> interrupt lines for each watchdog, and corresponding interrupt
> control/status registers. Watchdog control registers were also
> slightly rearranged.
>
> Also replace ioread32()/iowrite32() with readl()/writel() in various
> places changed.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
