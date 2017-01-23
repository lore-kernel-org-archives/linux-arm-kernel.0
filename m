From: robh@kernel.org (Rob Herring)
Date: Mon, 23 Jan 2017 14:04:14 -0600
Subject: [PATCH 06/22] gpio: add DT bindings for Cortina Gemini GPIO
In-Reply-To: <20170122121830.10336-1-linus.walleij@linaro.org>
References: <20170122121830.10336-1-linus.walleij@linaro.org>
Message-ID: <20170123200414.vmwmcvutdy5goshs@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2017 at 01:18:30PM +0100, Linus Walleij wrote:
> This adds fairly standard DT bindings for the Cortina Systems
> Gemini GPIO controller.
> 
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Note to self: just apply this to the GPIO tree when discussion is over.
> ---
>  .../bindings/gpio/cortina,gemini-gpio.txt          | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/cortina,gemini-gpio.txt

Acked-by: Rob Herring <robh@kernel.org>
