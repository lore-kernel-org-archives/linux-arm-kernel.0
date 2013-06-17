From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 15:42:15 +0200
Subject: [RFC PATCH 05/11] dma: amba-pl08x: Add support for different
 maximum transfer size
In-Reply-To: <1371416058-22047-6-git-send-email-tomasz.figa@gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-6-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdaHpNVXueXy0HRnKTshn4ZZSPFh-pgav6B0UAU1xqsNCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 10:54 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> PL080S has separate register to store transfer size in, allowing single
> transfer to be much larger than in standard PL080.
>
> This patch makes the amba-pl08x driver aware of this and removes writing
> transfer size to reserved bits of CH_CONTROL register on PL080S, which
> was not a problem witn transfer sizes fitting the original bitfield
> of PL080, but now would overwrite other fields.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Very straight-forward.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
