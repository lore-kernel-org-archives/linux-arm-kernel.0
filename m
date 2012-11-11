From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Nov 2012 19:18:53 +0100
Subject: [PATCH] pinctrl: SPEAr: Add SoC specific gpio configuration
 routines
In-Reply-To: <440eeee0b362a9b2db3749a49c78b6aabdd5ad6a.1352298892.git.viresh.kumar@linaro.org>
References: <440eeee0b362a9b2db3749a49c78b6aabdd5ad6a.1352298892.git.viresh.kumar@linaro.org>
Message-ID: <CACRpkda7oBa5xwefsck71KefsTV_nuOB8ybiK_VieZtQchp4Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2012 at 3:37 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> From: Shiraz Hashim <shiraz.hashim@st.com>
>
> Different SPEAr SoCs have different approach to configure pins as gpios. Some
> configure a group of gpios with single register bit and others have one bit per
> gpio pin. Only earlier one is implemented till now, this patch adds support for
> later one.
>
> Here we add callbacks to SoC specific code to configure gpios in
> gpio_request_enable(). That will do additional SoC specific configuration to
> enable gpio pins.
>
> We also implement this callback for SPEAr1340 in this patch.
>
> Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied.

Thanks!
Linus Walleij
