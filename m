From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Apr 2014 20:14:40 +0200
Subject: [PATCH 04/15] pinctrl: sunxi: specify clk name when retrieving
 pinctrl pio clk
In-Reply-To: <1397051478-4113-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397051478-4113-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <CACRpkdYW6b_37V40TRxs=7ecaWuV0X7_YJ4=-Psr9CG-cTb79w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 9, 2014 at 3:51 PM, Boris BREZILLON
<boris.brezillon@free-electrons.com> wrote:

> Specify base pio clk name when retrieving it using the CCF.
> This way we will avoid conflicts when introducing a second clk for the A31
> SoC.
>
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>

Are you merging all these through ARM SoC?

In that case
Acked-by: Linus Walleij <linus.walleij@linaro.org>

If it's OK to merge stand-alone tell me and I'll apply it to
the pinctrl tree.

Yours,
Linus Walleij
