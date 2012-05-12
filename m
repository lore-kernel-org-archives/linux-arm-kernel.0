From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 May 2012 13:21:32 +0000
Subject: [PATCH v9 2/2] gpio: Device tree support for LPC32xx
In-Reply-To: <1336729660-7670-2-git-send-email-stigge@antcom.de>
References: <1336729660-7670-1-git-send-email-stigge@antcom.de>
 <1336729660-7670-2-git-send-email-stigge@antcom.de>
Message-ID: <201205121321.33106.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 May 2012, Roland Stigge wrote:
> This patch adds device tree support for gpio-lpc32xx.c.
> 
> To register the various GPIO banks as (struct) gpio_chips via the same DT
> gpio-controller, we utilize the adjusted of_xlate API to manipulate the
> actually used struct gpio_chip.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
