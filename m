From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 21 Sep 2014 09:32:53 -0700
Subject: [PATCH v2 2/2] watchdog: sunxi: Add A31 watchdog support
In-Reply-To: <1411315519-26257-3-git-send-email-wens@csie.org>
References: <1411315519-26257-1-git-send-email-wens@csie.org>
 <1411315519-26257-3-git-send-email-wens@csie.org>
Message-ID: <541EFDB5.5040503@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21/2014 09:05 AM, Chen-Yu Tsai wrote:
> This patch adds support for the watchdog hardware found in A31 and
> newer SoCs. This new hardware has registers at different offsets, and
> the system reset control has been split out of the "mode" register
> into a new "configuration" register.
>
> Differences not supported by this driver include separate interrupt
> lines for each watchdog, instead of sharing an interrupt line and
> registers with the timer block.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
