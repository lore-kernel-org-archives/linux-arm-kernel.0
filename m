From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 25 Jan 2014 10:21:57 -0800
Subject: [PATCH v4 10/18] watchdog: orion: Introduce an orion_watchdog
 device structure
In-Reply-To: <1390431915-5115-11-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390431915-5115-11-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <52E400C5.5070809@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2014 03:05 PM, Ezequiel Garcia wrote:
> In order to prepare to support multiple compatible-strings, this
> commit adds a device structure to hold the driver's state.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
