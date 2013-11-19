From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Nov 2013 22:02:21 +0100
Subject: [PATCH 01/10] dma: ste_dma40: Expand DT binding to accept
 'high-priority channel' flag
In-Reply-To: <1384859269-19801-2-git-send-email-lee.jones@linaro.org>
References: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
 <1384859269-19801-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZKKeTOReMey5+yOeX+4-7vPWgnKx-b8p68ECdweXpQug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 12:07 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This is used for MSP (audio) devices which is about to be fully DT:ed.
>
> Cc: devicetree at vger.kernel.org
> Acked-by: Vinod Koul <vinod.koul@intel.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Since this was ACKed by Vinod I have applied it to the ux500-devicetree
branch.

Yours,
Linus Walleij
