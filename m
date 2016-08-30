From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Aug 2016 16:41:59 +0200
Subject: [PATCH 1/3] ARM: integrator: delete some auxdata
In-Reply-To: <1472565569-11414-1-git-send-email-linus.walleij@linaro.org>
References: <1472565569-11414-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201608301641.59299.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 August 2016, Linus Walleij wrote:
> There is just a few auxdata entries still needed on the Integrators:
> 
> - UART RTS/CTS callbacks for Integrator/AP
> - MMC/SD special card detect quirk for Integrator/CP
> 
> Delete the rest.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Nice patches! I've had a look over them and they all seem reasonable,
and I didn't see any obvious other parts that can be as easily removed
here (I thought I did at first, but they all ended up being
slightly trickier).

	Arnd
