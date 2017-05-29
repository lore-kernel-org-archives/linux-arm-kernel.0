From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 May 2017 18:40:47 +0200
Subject: [PATCH v3 05/10] dt-bindings: add compatible string for Allwinner
 R40 pinctrl
In-Reply-To: <20170527102308.1988-6-icenowy@aosc.io>
References: <20170527102308.1988-1-icenowy@aosc.io>
 <20170527102308.1988-6-icenowy@aosc.io>
Message-ID: <CACRpkdYbumcyJLcRGeWn1BRD-XuDi96jRm9hVcoerGkG2wRO9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 27, 2017 at 12:23 PM, Icenowy Zheng <icenowy@aosc.io> wrote:

> Allwinner R40 has a pin controller like the ones in older Allwinner SoCs
> (especially A20), and can use modified version of the A10/A20 pinctrl
> driver.
>
> Add a compatible string for it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v3:
> - Added Rob's ACK.

Patch applied with Chen-Yu's review tag.

Yours,
Linus Walleij
