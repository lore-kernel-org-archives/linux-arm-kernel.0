From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 1 Jun 2015 14:44:33 +0200
Subject: [RESEND PATCH 2/2] pinctrl: zynq: fix offset address for {SD0,
 SD1}_WP_CD_SEL
In-Reply-To: <1432111351-21336-3-git-send-email-yamada.masahiro@socionext.com>
References: <1432111351-21336-1-git-send-email-yamada.masahiro@socionext.com>
 <1432111351-21336-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkda6UV72Zhg2S9xuMXnhBq32yPTSqwCLbSPEHBHn3ist8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 10:42 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> The address for SD0_WP_CD_SEL, SD1_WP_CD_SEL is 0xf8000830,
> 0xf8000834, respectively.
>
> Each offset address must be prefixed with 0x.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

No reply from S?ren, but applying anyway since it seems to make sense.
Only for -next though.

Yours,
Linus Walleij
