From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Jun 2017 11:44:33 +0200
Subject: [PATCH 1/2] pinctrl: armada-37xx: Fix uart2 group selection
 register mask
In-Reply-To: <20170623122952.9871-2-gregory.clement@free-electrons.com>
References: <20170623122952.9871-1-gregory.clement@free-electrons.com>
 <20170623122952.9871-2-gregory.clement@free-electrons.com>
Message-ID: <CACRpkdYsWrT-q5baD-Y7RYs2aQ2J3suEcEe4G8GceJUYS7JXyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 2:29 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> From: Ken Ma <make@marvell.com>
>
> If north bridge selection register bit1 is clear, pins [10:8] are for
> SDIO0 Resetn, Wakeup, and PDN while if bit1 is set, pins [10:8]are for
> GPIO; when bit1 is clear, pin 9 and pin 10 can be used for uart2 RTSn
> and CTSn, so bit1 should be added to uart2 group and it must be set
> for both "gpio" and "uart" functions of uart2 group.
>
> Signed-off-by: Ken Ma <make@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
