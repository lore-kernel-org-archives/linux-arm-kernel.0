From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Nov 2017 08:49:26 +0100
Subject: [PATCH 01/10] dmaengine: virt-dma: Add helper to free/reuse a
 descriptor
In-Reply-To: <20171114143212.8311-2-peter.ujfalusi@ti.com>
References: <20171114143212.8311-1-peter.ujfalusi@ti.com>
 <20171114143212.8311-2-peter.ujfalusi@ti.com>
Message-ID: <CACRpkdaSphm3w4MOWr=51qzQpGDiak+Q094bVkyCAwiWez8Kog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 14, 2017 at 3:32 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> The vchan_vdesc_fini() can be used to free or reuse a given descriptor
> after it has been marked as completed.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
