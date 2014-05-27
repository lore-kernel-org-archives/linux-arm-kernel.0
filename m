From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 May 2014 11:27:38 +0200
Subject: [PATCH] pinctrl: sunxi: fix pin numbers passed to register offset
 helpers
In-Reply-To: <1400772055-3852-1-git-send-email-wens@csie.org>
References: <1400772055-3852-1-git-send-email-wens@csie.org>
Message-ID: <CACRpkdYCLoc=fVnSPOQhhk2r+J6d7wP_getKHbwk7fA+bMyRcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 5:20 PM, Chen-Yu Tsai <wens@csie.org> wrote:

> The pin numbers passed to sunxi_*_reg helpers to get the correct
> registers should be the pin offset for the PIO block, not the
> absolute number we use that is based on the alphanumeric labels
> Allwinner uses.
>
> This patch subtracts .pin_base from the pin number passed to these
> functions, so the driver accesses the correct registers.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Patch applied with Boris' and Maximes Reviewd/ACK tags.

Yours,
Linus Walleij
