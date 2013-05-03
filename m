From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 21:53:40 +0200
Subject: [PATCH 08/63] dmaengine: ste_dma40: Move default memcpy configs
 into the driver
In-Reply-To: <1367591569-32197-9-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-9-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbBWdxCHRjJ_Q-PF4bROnW6s7FXbCineuoxUEk_VJopUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:31 PM, Lee Jones <lee.jones@linaro.org> wrote:

> There are only two default memcpy configurations used for the DMA40
> driver; one for physical memcpy and one for logical memcpy. Instead
> of invariably passing the same configurations though platform data,
> we're moving them into the driver instead.
>
> Acked-by: Vinod Koul <vnod.koul@intel.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied with some fuzzing to my ux500-dma40 branch.

Yours,
Linus Walleij
