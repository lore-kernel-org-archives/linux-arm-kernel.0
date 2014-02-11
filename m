From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 11 Feb 2014 08:46:01 -0800
Subject: [PATCH] ARM: ux500: disable msp2 device tree node
In-Reply-To: <1392123757-7982-1-git-send-email-linus.walleij@linaro.org>
 (Linus Walleij's message of "Tue, 11 Feb 2014 14:02:37 +0100")
References: <1392123757-7982-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <7hy51h7g3a.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> Commit 70b41abc151f9
> "ARM: ux500: move MSP pin control to the device tree"
> accidentally activated MSP2, giving rise to a boot scroll
> scream as the kernel attempts to probe a driver for it and
> fails to obtain DMA channel 14.
>
> Fix this up by marking the node disabled again.
>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi ARM SoC guys, can you please apply this patch directly
> for fixes, there is no point to send a pull request with a
> single patch in it.

Applied to fixes,

Kevin
