From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Mar 2017 14:09:16 +0100
Subject: [PATCH v2 1/5] pinctrl: sunxi: refactor pinctrl choice selecting
 for ARM64
In-Reply-To: <20170301180111.12365-2-icenowy@aosc.xyz>
References: <20170301180111.12365-1-icenowy@aosc.xyz>
 <20170301180111.12365-2-icenowy@aosc.xyz>
Message-ID: <CACRpkdZzTFAn-Mkm+SUwoatbV3RzyqoSVMB0dqkNhuDsYY56AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 1, 2017 at 7:01 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:

> ARM64 Allwinner SoCs used to have every pinctrl driver selected in
> ARCH_SUNXI. Change this to make their default value to (ARM64 &&
> ARCH_SUNXI).
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
