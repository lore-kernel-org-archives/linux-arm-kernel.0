From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 May 2016 15:40:38 +0200
Subject: [PATCH] pinctrl: stm32: Implement .pin_config_dbg_show()
In-Reply-To: <5733364A.3090606@st.com>
References: <1461939943-24752-1-git-send-email-patrice.chotard@st.com>
 <CACRpkdZ=KsPL1mBS1bLi=jYsv=Vb1QNBi8XPAJW50doPcwBuZg@mail.gmail.com>
 <5733364A.3090606@st.com>
Message-ID: <CACRpkdawoqfqN8YeojyrzPru2fwrFMidc1e2v7yxHRpPf+rK6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 3:40 PM, Patrice Chotard <patrice.chotard@st.com> wrote:
> On 05/10/2016 01:50 PM, Linus Walleij wrote:

> Sorry i didn't pay attention, but there is a compilation warning in this
> patch.
>
> drivers/pinctrl/stm32/pinctrl-stm32.c:823:7: warning: too many arguments for
> format [-Wformat-extra-args]
>        speeds[speed], "speed");
>
>
> What do you prefer ?
>  _ me to submit a v2 fixing this warning and at the same occasion include
> the requested code factorization
>  _ or submit additionnal patchset ?

Just send a patch on top fixing this.

Yours,
Linus Walleij
