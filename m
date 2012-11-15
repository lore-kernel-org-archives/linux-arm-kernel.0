From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Nov 2012 18:28:14 +0100
Subject: [PATCH 1/1] ARM: ux500: Describe UART platform registering issues
 more accurately
In-Reply-To: <1352968401-6092-1-git-send-email-lee.jones@linaro.org>
References: <1352968401-6092-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkda_AU+3kfjXQ4nA8JCoxdPmOVDdRhqSsQ3tUP5mS0jNMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 9:33 AM, Lee Jones <lee.jones@linaro.org> wrote:

> UARTs no longer require call-back information, since the reset
> call-back was removed in 43b5f0d69291374f602ad8e1817f329573a59010.
> The only AUXDATA dependencies remaining for UARTs are DMA settings.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
