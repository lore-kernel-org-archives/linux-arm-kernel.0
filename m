From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 May 2018 09:00:08 +0200
Subject: [PATCH v2 5/8] pinctrl: optionally stop deferring probe at end of
 initcalls
In-Reply-To: <20180524175024.19874-6-robh@kernel.org>
References: <20180524175024.19874-1-robh@kernel.org>
 <20180524175024.19874-6-robh@kernel.org>
Message-ID: <CACRpkdZ_xrHkrprb=7BiOCrnJrAsXNZVnYDf2Jcp4gF99W+pCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 7:50 PM, Rob Herring <robh@kernel.org> wrote:

> If the pinctrl node in DT indicates that pin setup is optional and the
> defaults can be used with the 'pinctrl-use-default', then only defer probe
> until initcalls are done. This gives platforms the option to work without
> their pinctrl driver being enabled.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

I trust that you know what you're doing so I guess
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
