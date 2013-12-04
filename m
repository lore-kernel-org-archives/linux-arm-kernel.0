From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 4 Dec 2013 09:08:49 -0800
Subject: [PATCH v4] ARM/serial: at91: switch atmel serial to use gpiolib
In-Reply-To: <1383816355-2956-1-git-send-email-linus.walleij@linaro.org>
References: <1383816355-2956-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131204170849.GB14859@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 07, 2013 at 10:25:55AM +0100, Linus Walleij wrote:
> This passes the errata fix using a GPIO to control the RTS pin
> on one of the AT91 chips to use gpiolib instead of the
> AT91-specific interfaces. Also remove the reliance on
> compile-time #defines and the cpu_* check and rely on the
> platform passing down the proper GPIO pin through platform
> data.
> 
> This is a prerequisite for getting rid of the local GPIO
> implementation in the AT91 platform and move toward
> multiplatform.
> 
> The patch also adds device tree support for getting the
> RTS GPIO pin from the device tree on DT boot paths.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
