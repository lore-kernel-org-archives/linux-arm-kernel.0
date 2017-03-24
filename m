From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 Mar 2017 10:54:14 +0100
Subject: [PATCH 1/4 v5] PCI: add DT bindings for Faraday Technology PCI
 Host Bridge
In-Reply-To: <20170312222352.2413-1-linus.walleij@linaro.org>
References: <20170312222352.2413-1-linus.walleij@linaro.org>
Message-ID: <CACRpkdZ7mQuaYUTVuKEC=FRmx7ie64cd_R0O58C10Kpm75-mAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 12, 2017 at 11:23 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> This adds device tree bindings for the Faraday technology PCI
> Host Bridge. This IP is found in the Storlink/Storm/Cortina
> Gemini SoC platform.
>
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: devicetree at vger.kernel.org
> Cc: Feng-Hsin Chiang <john453@faraday-tech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v4->v5:
> - No changes, just resend as everything else is rebased onto
>   v4.11-rc1.

Bjorn do you have any further comments or can we queue patch
1+2 of this series?

I want to submit the DTS patches to the ARM SoC tree, so I need
to be sure the bindings+driver are merge material first.

Yours,
Linus Walleij
