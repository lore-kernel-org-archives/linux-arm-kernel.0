From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Mar 2018 15:07:17 +0200
Subject: [PATCH v4 2/9] pinctrl: sunxi: introduce IRQ bank conversion
 function
In-Reply-To: <20180316140215.28663-3-icenowy@aosc.io>
References: <20180316140215.28663-1-icenowy@aosc.io>
 <20180316140215.28663-3-icenowy@aosc.io>
Message-ID: <CACRpkdYZQZTGm3R_Jq28mVf5krSBVyHO5WwtqO6rgAYBFHHTZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 3:02 PM, Icenowy Zheng <icenowy@aosc.io> wrote:

> The Allwinner H6 SoC have its pin controllers with the first IRQ-capable
> GPIO bank at IRQ bank 1 and the second bank at IRQ bank 5. Some
> refactors in the sunxi pinctrl framework are needed.
>
> This commit introduces a IRQ bank conversion function, which replaces
> the "(bank_base + bank)" code in IRQ register access.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Extracted in v4.

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
