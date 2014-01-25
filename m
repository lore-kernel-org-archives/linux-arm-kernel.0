From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 25 Jan 2014 10:12:07 -0800
Subject: [PATCH v4 03/18] watchdog: orion: Add clock error handling
In-Reply-To: <1390431915-5115-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390431915-5115-4-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <52E3FE77.9050809@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2014 03:05 PM, Ezequiel Garcia wrote:
> This commit adds a check for clk_prepare_enable success and introduces
> an error path to disable the clock properly.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
