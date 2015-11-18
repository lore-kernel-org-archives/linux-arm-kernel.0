From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Nov 2015 14:54:48 +0100
Subject: [PATCH] pinctrl: mediatek: Add get_direction support.
In-Reply-To: <1447798633-24586-1-git-send-email-hongzhou.yang@mediatek.com>
References: <1447798633-24586-1-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CACRpkdYbY7vDNRdMF_goUkwNHnoDAF9RMmAt-+sPqA1=8Hxouw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 11:17 PM, Hongzhou Yang
<hongzhou.yang@mediatek.com> wrote:

> Since Linux gpio framework return 0 for output, 1 for input.
> But HW use 0 stands for input, and 1 stands for output.
> So use negative to correct it.
>
> And gpio_chip.get is used to get input value, no need to get
> output value, so removing it.
>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

Patch applied for fixes.

Yours,
Linus Walleij
