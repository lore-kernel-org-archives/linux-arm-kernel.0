From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Mar 2014 11:11:45 +0800
Subject: [PATCH 0/5] Add STiH407 SoC and reference board support
In-Reply-To: <1393589841-6634-1-git-send-email-maxime.coquelin@st.com>
References: <1393589841-6634-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <CACRpkdbztgbWn3kmm4gv6OLcX+bPnyK5BCt0SJJcWo+iyGsWvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 8:17 PM, Maxime COQUELIN <maxime.coquelin@st.com> wrote:

> This series adds basic support to the STMicroelectronics STiH407 SoC and its
> B2120 reference board. The STiH407 is a dual-core ARM Cortex-A9 CPU aimed at
> STB market.
>
> Giuseppe Cavallaro (2):
>   ARM: STi: add pinctrl support for the STiH407 SoC
>   pinctrl: st: Enhance the controller to manage unavailable registers
>
> Maxime Coquelin (3):
>   ARM: STi: Add STiH407 SoC support
>   ARM: dts: Add STiH407 SoC support
>   ARM: dts: STiH407: Add B2120 board support

So I'd like to take the pinctrl patch through my tree and the rest through
ARM SoC but it seems it does not apply :-/

Yours,
Linus Walleij
