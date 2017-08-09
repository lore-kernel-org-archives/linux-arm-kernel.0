From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Aug 2017 18:47:37 -0500
Subject: [PATCH 1/5 v2] pinctrl: Add DT bindings for Cortina Gemini
In-Reply-To: <20170731213050.4794-1-linus.walleij@linaro.org>
References: <20170731213050.4794-1-linus.walleij@linaro.org>
Message-ID: <20170809234737.tpjapxylixaqnmnl@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 11:30:50PM +0200, Linus Walleij wrote:
> The Cortina Gemini pin controller uses the standard pin control
> bindings for muxing functions with groups so these bindings
> should be entirely uncontroversial.
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - State that the pin controller must be a subnode of the
>   system controller.
> - Drop the phandle to the system controller: we can simply
>   look up the parent.
> ---
>  .../bindings/pinctrl/cortina,gemini-pinctrl.txt    | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/cortina,gemini-pinctrl.txt

Acked-by: Rob Herring <robh@kernel.org>
