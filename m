From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 10:58:46 +0200
Subject: [PATCH 33/39] dmaengine: ste_dma40_ll: Use the BIT macro to
 replace ugly '(1 << x)'s
In-Reply-To: <1368611522-9984-34-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-34-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbzVSty9yX9sJxv6D9ADYj1qfB+z_rd3XUyq1W0sVcE3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> The aim is to make the code that little more readable.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied with Vinod's ACK.

Yours,
Linus Walleij
