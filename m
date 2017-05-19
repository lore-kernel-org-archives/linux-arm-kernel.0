From: robh@kernel.org (Rob Herring)
Date: Thu, 18 May 2017 20:36:49 -0500
Subject: [PATCH 1/5 v3] dt-bindings: Augment Gemini for clocks, resets
In-Reply-To: <20170515171839.953-1-linus.walleij@linaro.org>
References: <20170515171839.953-1-linus.walleij@linaro.org>
Message-ID: <20170519013649.trvu3ss6hc3edtcn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 07:18:39PM +0200, Linus Walleij wrote:
> This augments the platform bindings for the Gemini SoC to include
> the fact that the system controller also provides clock and reset
> lindes, and adds all the required include files.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Essentially a new patch from the two old patches adding
>   bindings to the reset and clock controller separately.
>   Instead add it all into the system controller and use one
>   single compatible.
> 
> Rob: I need to merge this together in front of the device tree
> changes that sprinkle references to the headers all over the
> Gemini device trees, so if this sits good with you please ACK
> it.
> ---
>  Documentation/devicetree/bindings/arm/gemini.txt | 24 +++++++++++++++-
>  include/dt-bindings/clock/cortina,gemini-clock.h | 29 +++++++++++++++++++
>  include/dt-bindings/reset/cortina,gemini-reset.h | 36 ++++++++++++++++++++++++
>  3 files changed, 88 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/clock/cortina,gemini-clock.h
>  create mode 100644 include/dt-bindings/reset/cortina,gemini-reset.h

Acked-by: Rob Herring <robh@kernel.org>
