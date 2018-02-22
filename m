From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Feb 2018 13:47:19 +0100
Subject: [PATCH v5 1/5] ARM: bcm2835: sync firmware properties with
 downstream
In-Reply-To: <e7d1f1d0789f11d37957a8998bee23d035115aeb.1519128054.git.baruch@tkos.co.il>
References: <cover.1519128054.git.baruch@tkos.co.il>
 <e7d1f1d0789f11d37957a8998bee23d035115aeb.1519128054.git.baruch@tkos.co.il>
Message-ID: <CACRpkdZb79XBS-sZjJqx7bbphzRM1phM6-h8wRMBmiCe1VVnbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 1:19 PM, Baruch Siach <baruch@tkos.co.il> wrote:

> Add latest firmware property tags from the latest Raspberry Pi downstream
> kernel. This is needed for the GPIO tags, so we can control the GPIO
> multiplexor lines.
>
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v4: No change

Patch applied to the GPIO tree for v4.17.

But I changed the subject from ARM: to soc:

Yours,
Linus Walleij
