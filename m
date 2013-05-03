From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 23:12:52 +0200
Subject: [PATCH 30/63] ARM: ux500: Move SDI (MMC) and UART devices under
 more descriptive heading
In-Reply-To: <1367591569-32197-31-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-31-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbX_L_KAZqWWeGp1eVvUGBHgPX0cfr=zggsak+X3WNFzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Now DMA DT bindings exist and are in use by he MMC and UART drivers, it
> should be possible to remove them from the auxdata structure. However,
> after doing so the drivers fail. Common clk is still reliant on the
> dev_name() call to do device name matching, which will fail due to the
> fact that Device Tree naming differs somewhat do the more traditional
> conventions.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Can't apply this because of dependencies on the two previous
patches which also have dependencies.

Yours,
Linus Walleij
