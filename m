From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 12:57:58 +0000
Subject: [PATCH v8] gpio: Device tree support for LPC32xx
In-Reply-To: <1336076428-29419-1-git-send-email-stigge@antcom.de>
References: <1336076428-29419-1-git-send-email-stigge@antcom.de>
Message-ID: <201205041257.58252.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 May 2012, Roland Stigge wrote:
> This patch adds device tree support for gpio-lpc32xx.c.
> 
> The various GPIO groups correspond to the different irregular GPIO banks of the
> LPC32xx hardware. Most importantly, there are the GPI(0-27), GPO(0-23) and
> GPIO(0-5) banks. Each bank must be registered individually since they are
> implemented with different functions. Registration is done via gpiochip_add()
> which requires an individual gpio bank subnode in the device tree for each
> call.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
