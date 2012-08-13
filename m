From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Aug 2012 16:20:10 +0200
Subject: [PATCH] pinctrl: imx51: fix .conf_reg of
 MX51_PAD_SD2_CMD__CSPI_MOSI
In-Reply-To: <1344867532-27068-1-git-send-email-shawn.guo@linaro.org>
References: <1344867532-27068-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdZB_NvS+PVY8fGuJggK3FhE_--MuBYXVAVDDmsPBjcvGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2012 at 4:18 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> The .conf_reg of MX51_PAD_SD2_CMD__CSPI_MOSI should be 0x7bc rather
> than NO_PAD.  This error will cause SD2 probe failure.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Applied to fixes.

Yours,
Linus Walleij
