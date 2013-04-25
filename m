From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 13:41:32 +0200
Subject: [PATCH 29/32] ARM: ux500: Stop passing UART's platform data for
 Device Tree boots
In-Reply-To: <1366279934-30761-30-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-30-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdadOsBSB3PNhhmguO5v6VbMMMrjLytYQrtcdY0CsOVKUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:12 PM, Lee Jones <lee.jones@linaro.org> wrote:

> It was required to pass DMA channel configuration information to the
> UART driver before the new DMA API was in place. Now that it is, and
> is fully compatible with Device Tree we can stop doing that.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Removes a nasty dependency to the board file as well!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
