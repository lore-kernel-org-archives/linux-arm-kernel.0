From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Sep 2014 16:53:59 +0200
Subject: [PATCH v2] pinctrl: st: remove gpiochip in failure cases
In-Reply-To: <1410249101-12234-1-git-send-email-pramod.gurav@smartplayin.com>
References: <1410249101-12234-1-git-send-email-pramod.gurav@smartplayin.com>
Message-ID: <CACRpkdZkQB_zTuvQA-8T=qMK7jgHPJQ3fZV_25haEnkJ8Loo9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 9, 2014 at 9:51 AM, Pramod Gurav
<pramod.gurav@smartplayin.com> wrote:

> This patch releases gpiochip related resources by calling
> gpiochip_remove when gpiochip_irqchip_add fails.
>
> CC: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> CC: Srinivas Kandagatla <srinivas.kandagatla@linaro.com>
> CC: Maxime Coquelin <maxime.coquelin@st.com>
> CC: Patrice Chotard <patrice.chotard@st.com>
> CC: Linus Walleij <linus.walleij@linaro.org>
> CC: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
> ---
> Changes since v1:
> Dropped adding remove function as it will never be tested as
> the driver is bool.

Patch applied with Srinivas ACK.

Yours,
Linus Walleij
