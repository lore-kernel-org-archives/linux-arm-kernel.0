From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Mar 2017 14:12:34 +0100
Subject: [PATCH v2 2/5] arm64: only select PINCTRL for Allwinner platforms
In-Reply-To: <20170301180111.12365-3-icenowy@aosc.xyz>
References: <20170301180111.12365-1-icenowy@aosc.xyz>
 <20170301180111.12365-3-icenowy@aosc.xyz>
Message-ID: <CACRpkdYJfycBqcAfu-K0i8TnEMwOZmDGvujHA25YWbBax6+6MA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 1, 2017 at 7:01 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:

> As the pinctrl driver selecting is refactored in Kconfig file of
> pinctrl-sunxi, now we can select only PINCTRL for Allwinner platform,
> and the default value of several pinctrl drivers useful on ARM64
> Allwinner SoCs will become Y.
>
> This is the situation of 32-bit ARM ARCH_SUNXI option.
>
> Drop the select of per-SoC pinctrl choices, but keep selecting PINCTRL.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Changes in v2:

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this through the ARM SoC tree.

Yours,
Linus Walleij
