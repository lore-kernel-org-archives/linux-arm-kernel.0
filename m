From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Jan 2016 11:47:32 +0100
Subject: [PATCH 1/2] ARM: versatile: add the syscon LEDs to the DT
In-Reply-To: <1452002529-3335-2-git-send-email-linus.walleij@linaro.org>
References: <1452002529-3335-1-git-send-email-linus.walleij@linaro.org>
 <1452002529-3335-2-git-send-email-linus.walleij@linaro.org>
Message-ID: <6267161.VOui2c95BW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 January 2016 15:02:08 Linus Walleij wrote:
> The device tree version of Versatile AP/PB never had LED support
> so we are missing LEDs from our hardware boards. Add this as
> syscon LEDs like we did for Integrator and Juno. We need to
> spawn devices in the syscon with "simple-mfd" for this to work.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 

Applied to next/dt, thanks!

	Arnd
