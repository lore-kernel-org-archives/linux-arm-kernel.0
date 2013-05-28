From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 28 May 2013 10:21:33 +0100
Subject: [PATCH] ARM: ux500: add ABx500 pinctrl tables
In-Reply-To: <1369726413-18676-1-git-send-email-linus.walleij@stericsson.com>
References: <1369726413-18676-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130528092133.GE22683@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 May 2013, Linus Walleij wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
> 
> This adds pin control tables for the ABx500 (AB8500 and
> AB8505) PMIC, which also happens to act as a multimedia
> pin expander on the ux500 platforms.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-ux500/board-mop500-pins.c | 262 ++++++++++++++++++++++++++++++++

Patch looks good to me. I don't see anything untoward:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
