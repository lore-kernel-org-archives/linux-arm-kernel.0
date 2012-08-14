From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 13:16:57 +0200
Subject: [PATCH 16/22] ARM: ux500: Stop registering the PCM driver from
 platform code
In-Reply-To: <1344527268-5964-17-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-17-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaGN3nh03sqvTic8oNXPmQisURJVx3nFZm7scuFzonN2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> We now initialise the PCM driver through the MSP DAI, so there is
> no need to register it though platform code anymore. This patch
> strips out all PCM platform registration.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
