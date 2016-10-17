From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 17 Oct 2016 16:13:50 -0700
Subject: [PATCH] bus: qcom-ebi2: depend on ARCH_QCOM or COMPILE_TEST
In-Reply-To: <1475582179-5085-1-git-send-email-linus.walleij@linaro.org>
References: <1475582179-5085-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20161017231350.GN8871@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04, Linus Walleij wrote:
> This hides the option for people who do not want their Kconfig
> vision cluttered (i.e. x86) and enables compile testing apart
> from the supported main arch.
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
