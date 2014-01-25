From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 25 Jan 2014 10:23:10 -0800
Subject: [PATCH v4 11/18] watchdog: orion: Introduce per-compatible
 of_device_id data
In-Reply-To: <1390431915-5115-12-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390431915-5115-12-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <52E4010E.8090002@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2014 03:05 PM, Ezequiel Garcia wrote:
> This commit adds an orion_watchdog_data structure to hold compatible-data
> information. This allows to remove the driver-wide definition and to
> be able to add support for multiple compatible-strings in the future.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
