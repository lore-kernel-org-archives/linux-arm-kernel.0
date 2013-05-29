From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 29 May 2013 20:10:28 +0100
Subject: [PATCH] ARM: ux500: use symbolic names for interrupt flags
In-Reply-To: <1369847989-10017-1-git-send-email-linus.walleij@stericsson.com>
References: <1369847989-10017-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130529191028.GL3012@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 May 2013, Linus Walleij wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This switches to including <dt-bindings/interrupt-controller/irq.h>
> and referencing the apropriate flags from there instead of
> open-coding the flag numerals everywhere in the ux500 device
> trees.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/boot/dts/dbx5x0.dtsi  | 104 +++++++++++++++++++++--------------------
>  arch/arm/boot/dts/href.dtsi    |   5 +-
>  arch/arm/boot/dts/snowball.dts |   2 +-
>  arch/arm/boot/dts/stuib.dtsi   |   4 +-
>  4 files changed, 60 insertions(+), 55 deletions(-)

/me likes this.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
