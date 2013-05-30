From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 10:47:38 +0200
Subject: [PATCH 29/39] dmaengine: ste_dma40: Use the BIT macro to replace
 ugly '(1 << x)'s
In-Reply-To: <1368611522-9984-30-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-30-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYgu3q8s=jMfQ1L-WEoDxRz4gQW6+jqZ8RTVvCAnLQKVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> The aim is to make the code that little more readable.
>
> Acked-by: Vinod Koul <vnod.koul@intel.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied to my ux500-dma40 branch.

Yours,
Linus Walleij
