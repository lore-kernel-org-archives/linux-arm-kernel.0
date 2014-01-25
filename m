From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 25 Jan 2014 10:20:17 -0800
Subject: [PATCH v4 09/18] watchdog: orion: Remove unneeded BRIDGE_CAUSE
 clear
In-Reply-To: <1390431915-5115-10-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390431915-5115-10-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <52E40061.9060603@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2014 03:05 PM, Ezequiel Garcia wrote:
> After adding the IRQ request, the BRIDGE_CAUSE bit should be cleared by the
> bridge interrupt controller. There's no longer a need to do it in the watchdog
> driver, so we can simply remove it.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
