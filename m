From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Sep 2014 18:53:28 +0200
Subject: [PATCH] pinctrl: st: Add remove function and remove gpio_chip on
 failure
In-Reply-To: <1409409935-8775-1-git-send-email-pramod.gurav@smartplayin.com>
References: <1409409935-8775-1-git-send-email-pramod.gurav@smartplayin.com>
Message-ID: <CACRpkdbYP3AMZEyeJnS0H6rgMs2sPOaW4xvRSnRVDLs=ahk=jA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 30, 2014 at 4:45 PM, Pramod Gurav
<pramod.gurav@smartplayin.com> wrote:

> This patch adds a remove function to platform_driver to unload
> the driver in a cleaner way. This also releases gpiochip related
> resources by calling gpiochip_remove when gpiochip_irqchip_add fails.
>
> CC: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> CC: Srinivas Kandagatla <srinivas.kandagatla@linaro.com>
> CC: Maxime Coquelin <maxime.coquelin@st.com>
> CC: Patrice Chotard <patrice.chotard@st.com>
> CC: Linus Walleij <linus.walleij@linaro.org>
> CC: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>

Srinivas/Patrice: can you have a look at this?

Yours,
Linus Walleij
