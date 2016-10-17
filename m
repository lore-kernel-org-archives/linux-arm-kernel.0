From: olof@lixom.net (Olof Johansson)
Date: Mon, 17 Oct 2016 13:46:18 -0700
Subject: [PATCH] bus: qcom-ebi2: depend on ARCH_QCOM or COMPILE_TEST
In-Reply-To: <1475582179-5085-1-git-send-email-linus.walleij@linaro.org>
References: <1475582179-5085-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20161017204618.GB3264@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2016 at 01:56:19PM +0200, Linus Walleij wrote:
> This hides the option for people who do not want their Kconfig
> vision cluttered (i.e. x86) and enables compile testing apart
> from the supported main arch.
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC people: please apply this to next/drivers as well
> or as a fix depending on timing.

Applied to fixes. Thanks.


-Olof
