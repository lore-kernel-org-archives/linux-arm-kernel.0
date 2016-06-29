From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Jun 2016 10:30:25 +0200
Subject: [PATCH 2/2] pinctrl: qcom: msm8974: Add hsic_ctl pinmux
In-Reply-To: <20160626052132.7178-3-stephen.boyd@linaro.org>
References: <20160626052132.7178-1-stephen.boyd@linaro.org>
 <20160626052132.7178-3-stephen.boyd@linaro.org>
Message-ID: <CACRpkdYfs-8fj8_UqAxJUeRkYt5Y1KQC9dskwaWHmrA3-cD5Pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 26, 2016 at 7:21 AM, Stephen Boyd <stephen.boyd@linaro.org> wrote:

> The msm8974 pinctrl variant has a couple USB HSIC "glue"
> registers that let us mux between the pinctrl register settings
> or the HSIC core settings for the HSIC pins (gpio 144 and gpio
> 145). Support this method of operation by adding hsic_data and
> hsic_strobe pins that can select between hsic_ctl and gpio
> functions. This allows us to toggle the hsic pin configuration
> over to the HSIC core at runtime.
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>

Patch applied.

Yours,
Linus Walleij
