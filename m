From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 12 Apr 2014 10:44:48 -0700
Subject: [PATCH v2] watchdog: imx2_wdt: convert to watchdog core api
In-Reply-To: <1397199434-6551-1-git-send-email-agust@denx.de>
References: <1397199434-6551-1-git-send-email-agust@denx.de>
Message-ID: <53497B90.3010802@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2014 11:57 PM, Anatolij Gustschin wrote:
> Convert the imx2_wdt driver to the new watchdog core api.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> ---
> NOTE: This patch applies on top of the imx2_wdt regmap-mmio support
> patch series http://comments.gmane.org/gmane.linux.kernel/1677735
>
> Changes since first version:
>   - simplify return in imx2_wdt_is_running()
>   - fix "WARNING: quoted string split across lines"
>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
