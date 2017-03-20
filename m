From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Mar 2017 10:09:19 +0100
Subject: [PATCH v2 2/5] arm64: only select PINCTRL for Allwinner platforms
In-Reply-To: <CACRpkdYJfycBqcAfu-K0i8TnEMwOZmDGvujHA25YWbBax6+6MA@mail.gmail.com>
References: <20170301180111.12365-1-icenowy@aosc.xyz>
 <20170301180111.12365-3-icenowy@aosc.xyz>
 <CACRpkdYJfycBqcAfu-K0i8TnEMwOZmDGvujHA25YWbBax6+6MA@mail.gmail.com>
Message-ID: <20170320090919.ifngfkrwu2rcyegt@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 02:12:34PM +0100, Linus Walleij wrote:
> On Wed, Mar 1, 2017 at 7:01 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> 
> > As the pinctrl driver selecting is refactored in Kconfig file of
> > pinctrl-sunxi, now we can select only PINCTRL for Allwinner platform,
> > and the default value of several pinctrl drivers useful on ARM64
> > Allwinner SoCs will become Y.
> >
> > This is the situation of 32-bit ARM ARCH_SUNXI option.
> >
> > Drop the select of per-SoC pinctrl choices, but keep selecting PINCTRL.
> >
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> > ---
> > Changes in v2:
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Please funnel this through the ARM SoC tree.

Applied!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/81991dab/attachment.sig>
