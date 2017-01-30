From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Jan 2017 16:23:15 +0100
Subject: [PATCH v3 01/10] drivers: pinctrl: add driver for Allwinner H5 SoC
In-Reply-To: <20170129023331.62106-2-icenowy@aosc.xyz>
References: <20170129023331.62106-1-icenowy@aosc.xyz>
 <20170129023331.62106-2-icenowy@aosc.xyz>
Message-ID: <CACRpkdaj7tnd=anx2npYSKGm5EjmXtBCTvLeCbBk4nsCWrEZTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 3:33 AM, Icenowy Zheng <icenowy@aosc.xyz> wrote:

> Based on the Allwinner H5 datasheet and the pinctrl driver of the
> backward-compatible H3 this introduces the pin multiplex assignments for
> the H5 SoC.
>
> H5 introduced some more pin functions (e.g. three more groups of TS
> pins, and one more groups of SIM pins) than H3.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
> Changes in v3:
> - Add Maxime's ACK.
> Changes in v2:
> - Fixed interrupt banks. (There's one more GPIO banks (PF) that can do
>   interrupt handling on H5)

I already applied V2 with Maximes' ACK and all.

Yours,
Linus Walleij
