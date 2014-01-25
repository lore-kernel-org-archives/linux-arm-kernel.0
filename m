From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 25 Jan 2014 10:13:36 -0800
Subject: [PATCH v4 06/18] watchdog: orion: Make sure the watchdog is
 initially stopped
In-Reply-To: <1390431915-5115-7-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390431915-5115-7-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <52E3FED0.6040003@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2014 03:05 PM, Ezequiel Garcia wrote:
> Having the watchdog initially fully stopped is important to avoid
> any spurious watchdog triggers, in case the registers are not in
> its reset state.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
