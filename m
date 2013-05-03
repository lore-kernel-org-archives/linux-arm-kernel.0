From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 22:55:11 +0200
Subject: [PATCH 24/63] dmaengine: ste_dma40: Allocate plat_data on
 declaration
In-Reply-To: <1367591569-32197-25-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-25-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdayY5BH3t-0m9w9SW4Ru47=Vc6N9nV=vKvHTRMDTReLmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:

> It's the way that most other drivers do it.
>
> Very trivial clean-up which reduces line count and simplifies code.
>
> Acked-by: Vinod Koul <vnod.koul@intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to my ux500-dma40 branch.

Thanks!
Linus Walleij
