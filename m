From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 11:04:23 +0200
Subject: [PATCH 35/39] dmaengine: ste_dma40_ll: Replace meaningless
 register set with comment
In-Reply-To: <1368611522-9984-36-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-36-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbXVd7k9rzb-OKUmnW_9J+jWYhz=AjO09_Ymvd2_DOVcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> Unsure of the author's intentions, rather than just removing the nop,
> we're replacing it with a comment containing the possible intention
> of the statement OR:ing with 0.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Tentatively applied. Missing Vinod's ACK.

Yours,
Linus Walleij
