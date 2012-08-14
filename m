From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 13:14:46 +0200
Subject: [PATCH 14/22] ARM: ux500: Pass MSP DMA platform data though
 AUXDATA
In-Reply-To: <1344527268-5964-15-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-15-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbA87mRK23=t0vXg4jXNw-cW3Pepz5J3brBtbtJAz0saQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> It isn't currently possible to pass all platform specific configuration
> though Device Tree. Thinks like device names used in the clock
> infrastructure, call-backs and DMA information have to be passed in via
> AUXDATA structures and the MSP is no exception. Here we're passing DMA
> settings.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
