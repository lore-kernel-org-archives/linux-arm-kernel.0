From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Oct 2018 09:16:26 +0200
Subject: [PATCH V3 1/2] dt-bindings: pinctrl: document Broadcom Northstar
 pin mux controller
In-Reply-To: <20180926193103.21241-1-zajec5@gmail.com>
References: <20180926193103.21241-1-zajec5@gmail.com>
Message-ID: <CACRpkdb8MRQN4z=7ZMs8Y3nbUTjDSLqdFNK_AUozut726JwogA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2018 at 9:31 PM Rafa? Mi?ecki <zajec5@gmail.com> wrote:

> From: Rafa? Mi?ecki <rafal@milecki.pl>
>
> Northstar has mux controller just like Northstar Plus and Northstar2.
> It's a bit different though (different registers & pins) so it requires
> its own binding.
>
> It's needed to allow other block bindings specify required mux setup.
>
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> V2: Use "cru_gpio_control"
>     Add more functions & groups
>     Include Florian's Reviewed-by
> V3: Use 3 different bindings as available pins depend on the chipset.
>     Strings match Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt

Patch applied.

Yours,
Linus Walleij
