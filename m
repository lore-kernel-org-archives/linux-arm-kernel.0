From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Nov 2015 14:58:10 +0100
Subject: [PATCH] pinctrl: mediatek: Add get_direction support.
In-Reply-To: <1447462164-34639-1-git-send-email-hongzhou.yang@mediatek.com>
References: <1447462164-34639-1-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CACRpkdZw_cM2G5OtqpA_GOYL61Pzz0Qkx1H-Pzmi2u1TmHiBsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 14, 2015 at 1:49 AM, Hongzhou Yang
<hongzhou.yang@mediatek.com> wrote:

> Since Linux gpio framework return 0 for output, 1 for input.
> But HW use 0 stands for input, and 1 stands for output.
> So use negative to correct it.
>
> And gpio_chip.get is used to get input value, no need to get
> output value, so removing it.
>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> ---
>  Add get direction support.
>  Remove gpio_chip.get value for output direction.

This patch does not apply. Please rebase on v4.4-rc1
and resend.

Yours,
Linus Walleij
