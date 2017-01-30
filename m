From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Jan 2017 16:13:50 +0100
Subject: [PATCH v2 1/9] drivers: pinctrl: add driver for Allwinner H5 SoC
In-Reply-To: <20170126154859.55855-2-icenowy@aosc.xyz>
References: <20170126154859.55855-1-icenowy@aosc.xyz>
 <20170126154859.55855-2-icenowy@aosc.xyz>
Message-ID: <CACRpkdY=+wAVZtWjeW+jKq_s+YX17L7xUeZ14_sAyd8KCm6+kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 4:48 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:

> Based on the Allwinner H5 datasheet and the pinctrl driver of the
> backward-compatible H3 this introduces the pin multiplex assignments for
> the H5 SoC.
>
> H5 introduced some more pin functions (e.g. three more groups of TS
> pins, and one more groups of SIM pins) than H3.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Changes in v2:
> - Fixed interrupt banks. (There's one more GPIO banks (PF) that can do
>   interrupt handling on H5)

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
