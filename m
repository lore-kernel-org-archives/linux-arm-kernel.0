From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 21:51:07 +0200
Subject: [PATCH 07/63] dmaengine: ste_dma40: Assign memcpy channels in the
 driver
In-Reply-To: <1367591569-32197-8-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-8-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkda1ELOH_aHcmy1LOs3XpWrwdtOhQWpEXx5Uik5yOJVbng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:31 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The channels reserved for memcpy are the same for all currently
> supported platforms. With this in mind, we can ease the platform
> data passing requirement by moving these assignments out from
> platform code and place them directly into the driver.
>
> Acked-by: Vinod Koul <vnod.koul@intel.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied this to my ux500-dma40 branch, then applied the just mailed
fixup patch immediately after it.

Let's see how far ahead we get before I run into merge conflicts because
of this :-)

Yours,
Linus Walleij
