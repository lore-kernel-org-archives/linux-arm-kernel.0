From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 29 May 2013 20:08:02 +0100
Subject: [PATCH] ARM: ux500: cut chip-select GPIOs from SSP device
In-Reply-To: <1369848742-10451-1-git-send-email-linus.walleij@stericsson.com>
References: <1369848742-10451-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130529190802.GK3012@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 May 2013, Linus Walleij wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
> 
> What GPIO pin is used with which device on the SSP/SPI bus
> is as board-specific as it gets, so it does not belong here
> in the core SoC file, and it is disabled so it doesn't hurt
> to delete this.

Sounds fine.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
