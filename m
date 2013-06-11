From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Jun 2013 10:53:43 +0200
Subject: [PATCH 2/2 v3] pinctrl: add pinctrl driver for Rockchip SoCs
In-Reply-To: <201306102216.23292.heiko@sntech.de>
References: <201306102139.32444.heiko@sntech.de>
 <201306102142.52644.heiko@sntech.de>
 <201306102216.23292.heiko@sntech.de>
Message-ID: <CACRpkdaLq_sDq1v=_K20fj7nJ42-PssBUv+t__DsnTcn3Py2uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 10:16 PM, Heiko St?bner <heiko@sntech.de> wrote:

> This driver adds support the Cortex-A9 based SoCs from Rockchip,
> so at least the RK2928, RK3066 (a and b) and RK3188.
> Earlier Rockchip SoCs seem to use similar mechanics for gpio
> handling so should be supportable with relative small changes.
> Pull handling on the rk3188 is currently a stub, due to it being
> a bit different to the earlier SoCs.
>
> Pinmuxing as well as gpio (and interrupt-) handling tested on
> a rk3066a based machine.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> changes since v2:
> Found out how to handle the phandle in the regular rockchip,pins property
> 5 minutes after sending the v2 ... damn :-) .
> I'm terribly sorry for all the noise.
>
>
> After Stephen Warren's clarification, again with <dt-bindings/...> include.
> and of course adapted to the new expected dt node-structure

Thanks, this v3 version applied.

And don't worry about the noise, it is normal in situations like these
where we're seeing rapid development of core stuff and building
consensus.

Yours,
Linus Walleij
