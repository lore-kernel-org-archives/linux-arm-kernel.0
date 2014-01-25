From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 25 Jan 2014 10:24:01 -0800
Subject: [PATCH v4 12/18] watchdog: orion: Add per-compatible clock
 initialization
In-Reply-To: <1390431915-5115-13-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390431915-5115-13-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <52E40141.1050009@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2014 03:05 PM, Ezequiel Garcia wrote:
> Following the introduction of the compatible-data field,
> it's now possible to further abstract the clock initialization.
> This will allow to support SoC with a different clock setup.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
