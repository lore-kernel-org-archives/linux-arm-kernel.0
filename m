From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 13:24:39 +0200
Subject: [PATCH 23/32] dmaengine: ste_dma40: Allow driver to be
 probe()able when DT is enabled
In-Reply-To: <1366279934-30761-24-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-24-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbq3sz-e_ySUYf6a4PiWL4C=Yk=eNFUicUu03pDhJbPig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:12 PM, Lee Jones <lee.jones@linaro.org> wrote:

> When booting using Device Tree, devices aren't registered in the normal
> way. Instead, they need to be provided with a compatible string which is
> held in an OF Match Table for comparison during start-up. Here we provide
> the compatible string and prepare the driver to not receive a platform
> data pointer.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
