From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Apr 2013 16:44:44 +0200
Subject: [PATCH 02/32] dmaengine: ste_dma40: Move default memcpy configs
 into the driver
In-Reply-To: <1366279934-30761-3-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbBeyofVs=G3L-jSXuAv8GRYfwfUNPcV3TAfz2B9ACJ3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:11 PM, Lee Jones <lee.jones@linaro.org> wrote:

> There are only two default memcpy configurations used for the DMA40
> driver; one for physical memcpy and one for logical memcpy. Instead
> of invariably passing the same configurations though platform data,
> we're moving them into the driver instead.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Nice!

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
