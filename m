From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 May 2014 10:37:00 +0200
Subject: [PATCH] pinctrl: msm: Add more MSM8X74 pin definitions
In-Reply-To: <1399005842-27898-1-git-send-email-agross@codeaurora.org>
References: <1399005842-27898-1-git-send-email-agross@codeaurora.org>
Message-ID: <CACRpkdaZowxds1pLEEvaWwro2u=ycivzEwLkW0=Q2dgbTj3H9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 2, 2014 at 6:44 AM, Andy Gross <agross@codeaurora.org> wrote:

> This patch adds pin definitiones for the MSM8x74 TLMM.  New definitions
> include:
>
> BLSP devices (I2C, UART, UART flow control, SPI, and UIM), mi2s, gp clk, pdm,
> gcc clk, cci_timer, cci_i2c, cam_clk, hsic, tsif, sdc3, sdc4, and other assorted
> pins.
>
> Signed-off-by: Andy Gross <agross@codeaurora.org>

This patch does not apply on top of the pin control "devel" branch,
can you please rebase it on my tree, branch devel?
https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-pinctrl.git/

Also keep Bj?rn on CC so he can check/Ack this.

Yours,
Linus Walleij
