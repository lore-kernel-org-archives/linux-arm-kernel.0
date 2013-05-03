From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 22:15:16 +0200
Subject: [PATCH 17/63] dmaengine: ste_dma40: Calculate number of logical
 channels from physical ones
In-Reply-To: <1367591569-32197-18-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-18-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdatVVLX8S=OGUFs-ab+HZ6mrj6nyqCxg_YzojNJ=FJPoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This change will cost ~25KB of memory, but it's worth the trade-off,
> as it removes a great deal of overhead. It means that instead of only
> allocating memory for the logical channels in use, it does so for all
> available ones, which is 32 per physical channel. However, this now
> means we can remove some platform data and we don't have to worry
> about adding vendor specific variables to Device Tree.
>
> Acked-by: Vinod Koul <vnod.koul@intel.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied to my ux500-dma40 branch.

Thanks!
Linus Walleij
