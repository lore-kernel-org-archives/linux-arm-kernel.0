From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 1 Jun 2015 14:44:16 +0200
Subject: [RESEND PATCH 1/2] pinctrl: zynq: fix
 DEFINE_ZYNQ_PINMUX_FUNCTION_MUX macro
In-Reply-To: <1432111351-21336-2-git-send-email-yamada.masahiro@socionext.com>
References: <1432111351-21336-1-git-send-email-yamada.masahiro@socionext.com>
 <1432111351-21336-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdY0n-mdq4BSumUEJQENcWBdP2Y7kputm7Ek_LL4am6_Yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 10:42 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> The offset to the mux register is missing.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

No reply from S?ren, but applying anyway since it seems to make sense.
Only for -next though.

Yours,
Linus Walleij
