From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Mar 2015 10:39:47 +0100
Subject: [PATCH 07/11] pinctrl: berlin: use proper compatibles
In-Reply-To: <1423671332-24580-8-git-send-email-antoine.tenart@free-electrons.com>
References: <1423671332-24580-1-git-send-email-antoine.tenart@free-electrons.com>
 <1423671332-24580-8-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <CACRpkdb7Snqmp7DrvB=JN4DQqHTFzmmYyzKVb4TEoTijyvNVjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 5:15 PM, Antoine Tenart
<antoine.tenart@free-electrons.com> wrote:

> The Berlin pin-controller driver was sharing the chip and system
> controller nodes with the clock and the reset drivers. They all shared
> the same compatible. With the introduction of the Marvell Berlin MFD
> controller, the Berlin pin-controller driver has now its own node.
> Update its compatibles to not share anymore the ones of the chip and
> system controllers.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Tell me if you prefer that I merge this patch directly to the
pin control subsystem.

Yours,
Linus Walleij
