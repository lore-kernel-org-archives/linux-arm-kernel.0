From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Mar 2018 15:05:18 +0200
Subject: [PATCH v4 1/9] pinctrl: sunxi: refactor irq related register
 function to have desc
In-Reply-To: <20180316140215.28663-2-icenowy@aosc.io>
References: <20180316140215.28663-1-icenowy@aosc.io>
 <20180316140215.28663-2-icenowy@aosc.io>
Message-ID: <CACRpkdbO0KQEG_OXbswJkmWm=Ceiutx7vux6GJp8XVun+NiRbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 3:02 PM, Icenowy Zheng <icenowy@aosc.io> wrote:

> As the new H6 SoC has holes in the IRQ registers, refactor the IRQ
> related register function for getting the full pinctrl desc structure.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v4:
> - Adjusted parameter sequence.

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
