From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 May 2013 13:44:38 +0200
Subject: [PATCH] ARM: ux500: select SND_SOC_UX500 for ux500
In-Reply-To: <1369402093-27817-1-git-send-email-fabio.baltieri@linaro.org>
References: <1369402093-27817-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <CACRpkdbB7KjzUCf72gqN3ooiWYYkaaPrZUEDeG8HuLk3pTB72A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 3:28 PM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:

> Enable ux500 specific ALSA SoC drivers by default on u8500_defconfig.
>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>

Thanks, patch applied to my defconfig branch.

Now I can finally use the Snowball board to run sidplay.

Yours,
Linus Walleij
