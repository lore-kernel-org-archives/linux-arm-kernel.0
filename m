From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 22:58:00 +0200
Subject: [PATCH 25/63] dmaengine: ste_dma40: Allow driver to be
 probe()able when DT is enabled
In-Reply-To: <1367591569-32197-26-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-26-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbQLVGfvyJ5tkz7mv+kdAPuzDT1ASR_KzkQRmh0WS_+CQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:

> When booting using Device Tree, devices aren't registered in the normal
> way. Instead, they need to be provided with a compatible string which is
> held in an OF Match Table for comparison during start-up. Here we provide
> the compatible string and prepare the driver to not receive a platform
> data pointer.
>
> Acked-by: Vinod Koul <vnod.koul@intel.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Fixed up some whitespace error that git am was complaining about
and applied to ux500-dma40.

Thanks!
Linus Walleij
