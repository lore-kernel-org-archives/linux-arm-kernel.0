From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Dec 2013 14:09:19 +0100
Subject: [PATCH 5/8] gpio: twl4030: Fix regression for twl gpio output
In-Reply-To: <529DDCE3.5020902@ti.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-6-git-send-email-tony@atomide.com>
 <529DDCE3.5020902@ti.com>
Message-ID: <CACRpkdb1XEJjykRD3MGmjHvTX40JtTZU7uDRAvpGLBdoREChmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 3, 2013 at 2:30 PM, Roger Quadros <rogerq@ti.com> wrote:

(...)
> This patch causes a regression with LED outputs (GPO) on twl4030 on 3.13-rc2.
> As one of the LED GPO is used for USB host on beagleboard, it will cause failure
> of USB host probe.
(...)
> Below is a proposed fix for this.

Roger, Tony: what happened with this? Have you hashed this out?
I ACK Roger's fixup too if that needs to be merged into the OMAP
tree.

Yours,
Linus Walleij
