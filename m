From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 17 Oct 2013 11:00:22 +0200
Subject: [PATCH 00/28]: dmaengine: use DMA_COMPLETE for dma completion
 status
In-Reply-To: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
References: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
Message-ID: <CACRpkdatoVFOOYru1RWPZTA6Q+mjO9kL7NLf=W803n4rF4Dz8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 6:28 PM, Vinod Koul <vinod.koul@intel.com> wrote:

> As we recently discussed in [1], the DMA_SUCCESS is an misnomer. The dmaengine
> does not acknowledge that dma completed succesfully. It can only signal dma was
> completed by it. Hence we should use DMA_COMPLTE as status instead of
> DMA_SUCCESS
>
> [1]: http://www.spinics.net/lists/arm-kernel/msg278346.html

This make things more clear. The series:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
