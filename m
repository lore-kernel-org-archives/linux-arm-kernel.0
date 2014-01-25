From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 25 Jan 2014 10:24:37 -0800
Subject: [PATCH v4 13/18] watchdog: orion: Add per-compatible watchdog
 start implementation
In-Reply-To: <1390431915-5115-14-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390431915-5115-14-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <52E40165.1080508@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2014 03:05 PM, Ezequiel Garcia wrote:
> To handle differences between SoCs this commit adds per-compatible
> string start() function for the watchdog kick-off. This is preparation
> work and makes no functionality changes to the current driver.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
