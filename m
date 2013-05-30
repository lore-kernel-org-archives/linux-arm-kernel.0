From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 11:16:48 +0200
Subject: [PATCH 39/39] dmaengine: ste_dma40: Fetch disabled channels from
 DT
In-Reply-To: <1368611522-9984-40-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-40-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaSJ93+W3sRBB2hC87q0=KO5ZBTPa1TG4oy0nX0Jn_nYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:52 AM, Lee Jones <lee.jones@linaro.org> wrote:

> Some platforms have channels which are not available for normal use.
> This information is currently passed though platform data in internal
> BSP kernels. Once those platforms land, they'll need to configure them
> appropriately, so we may as well add the infrastructure.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied with Vinod's ACK.

Yours,
Linus Walleij
