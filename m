From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Feb 2018 13:49:31 +0100
Subject: [PATCH v5 2/5] dt-bindings: gpio: add raspberry pi GPIO expander
 binding
In-Reply-To: <f400b48cbcd8a138c39d4e8f63d6c1f569090dcc.1519128054.git.baruch@tkos.co.il>
References: <cover.1519128054.git.baruch@tkos.co.il>
 <f400b48cbcd8a138c39d4e8f63d6c1f569090dcc.1519128054.git.baruch@tkos.co.il>
Message-ID: <CACRpkdbRk3u+KWLLJFx1wB2BDb50d2QJ3b68wvrer1VOZ0tWQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 1:19 PM, Baruch Siach <baruch@tkos.co.il> wrote:

> The Raspberry Pi 3 GPIO expander is controlled by the VC4 firmware over
> I2C. The firmware mailbox interface allows the ARM core to control the
> GPIO lines.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v5:
>   * Remove the 'firmware' property
>   * Note that the gpio node is a child of the firmware node

This v5 patch applied to the GPIO tree for v4.17 with Rob's ACK.

Yours,
Linus Walleij
