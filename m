From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Dec 2013 11:15:10 +0100
Subject: [PATCH 2/2] clk: versatile: fixup IM-PD1 clock implementation
In-Reply-To: <1385326744-16445-1-git-send-email-linus.walleij@linaro.org>
References: <1385326744-16445-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdZmyh-a_0ANEeO-DnJ=E_vXsiT3YifoV+zFReJmekyt7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 24, 2013 at 9:59 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> Register both VCO clocks, give per-logical module unique names
> to the clocks so we can have several IM-PD1's connected (in
> theory). Implement all the fixed-factor clocks as children of
> VCO2.
>
> Tested by using the UARTs and the PL181 MMC block on the IM-PD1,
> works flawlessly.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi Mike, if you're happy with this, I'd like an ACK to carry it
> through the ARM SoC tree.

Mike, ping on this.

Yours,
Linus Walleij
