From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 11:06:07 +0200
Subject: [PATCH 36/39] dmaengine: ste_dma40: Allow memcpy channels to be
 configured from DT
In-Reply-To: <1368611522-9984-37-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-37-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkda1LOfPyzQRAwChSH9WtcCFnLNfFa5kp=8JWX0x7ioj+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> At this moment in time the memcpy channels which can be used by the D40
> are fixed, as each supported platform in Mainline uses the same ones.
> However, platforms do exist which don't follow this convention, so
> these will need to be tailored. Fortunately, these platforms will be DT
> only, so this change has very little impact on platform data.
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
