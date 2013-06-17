From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 15:31:27 +0200
Subject: [RFC PATCH 03/11] dma: amba-pl08x: Add support for different
 offset of CONFIG register
In-Reply-To: <1371416058-22047-4-git-send-email-tomasz.figa@gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-4-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdYbgnkoaSiZqc7o2QvE19hZEASScfv_3onZoMmr3L9CxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 10:54 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> Some variants of PL08x (namely PL080S, found in Samsung S3C64xx SoCs)
> have CONFIG register at different offset. This patch makes the driver
> use offset from vendor data struct.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Looks good to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
