From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 4 Jun 2013 13:08:00 +0100
Subject: [PATCH] ARM: ux500: drop any 0x prefix from I2C DT devices
In-Reply-To: <1370339596-21606-1-git-send-email-linus.walleij@stericsson.com>
References: <1370339596-21606-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130604120800.GM3370@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 04 Jun 2013, Linus Walleij wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This removes the "0x" prefix in front of the I2C DT device
> address designation for each I2C DT node in the ux500
> devicetree files.
> 
> Reported-by: Bryan Wu <cooloney@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/boot/dts/href.dtsi      | 2 +-
>  arch/arm/boot/dts/hrefprev60.dts | 2 +-
>  arch/arm/boot/dts/snowball.dts   | 6 +++---
>  arch/arm/boot/dts/stuib.dtsi     | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
