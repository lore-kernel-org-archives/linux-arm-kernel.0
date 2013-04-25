From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 13:43:18 +0200
Subject: [PATCH 30/32] ARM: ux500: Supply MMC DMA configuration via Device
 Tree
In-Reply-To: <1366279934-30761-31-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-31-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbYXxkC2y9zCNcMAAmmQ7+3V0Y=hq7zgtp5L=Ts9QzpQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:12 PM, Lee Jones <lee.jones@linaro.org> wrote:

> When requesting a channel, a DMA client needs to pass some pieces of
> information such as; request channel, device type, channel type and
> direction etc. Normally we do this in the form of platform data, but
> when DT is enabled we need to pass it using the driver's bindings
> instead.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This requires that the pending MMCI patch get merged *first* right?

So you need to make sure Russell will merge that (or ACK it
and include it) before you send any pull requests to me.

Apart from that it looks allright:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
