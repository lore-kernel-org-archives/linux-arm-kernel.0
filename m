From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Feb 2017 10:04:03 -0600
Subject: [PATCH 1/3 v2] watchdog: add DT bindings for Cortina Gemini
In-Reply-To: <20170128225905.24549-1-linus.walleij@linaro.org>
References: <20170128225905.24549-1-linus.walleij@linaro.org>
Message-ID: <20170201160403.dqf6einqko6q7dpl@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 28, 2017 at 11:59:05PM +0100, Linus Walleij wrote:
> This adds DT bindings for the Cortina systems Gemini SoC
> watchdog timer.
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Make the timeout an optional property
> - Do not mention any Linux defaults if the property is not there
> ---
>  .../bindings/watchdog/cortina,gemin-watchdog.txt        | 17 +++++++++++++++++

gemin?

With that fixed,

Acked-by: Rob Herring <robh@kernel.org>
