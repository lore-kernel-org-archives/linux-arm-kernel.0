From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 13:36:46 +0200
Subject: [PATCH 26/32] ARM: ux500: Supply UART's DMA configuration via
 Device Tree
In-Reply-To: <1366279934-30761-27-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-27-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZDQuFDb396fYtjZNr=O-5vrTHs+UwS5bqp8wet1PA93A@mail.gmail.com>
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

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
