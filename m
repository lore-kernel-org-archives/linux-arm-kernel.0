From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Dec 2017 08:34:22 +0100
Subject: [PATCH v5 0/4] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <20171211233625.5689-1-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171211233625.5689-1-lukma@denx.de>
Message-ID: <CACRpkdbCeBCENDcRcYBKTXVNz6H3t=WKHYP8Uf3WJ=Wvtib1Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 12:36 AM, Lukasz Majewski <lukma@denx.de> wrote:

> This patch series adds support for Liebherr's BK3 board, being
> a derivative of TS72XX design.

All looks good.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Out of curiosity: Liebherr is obviously doing heavy-duty industrial
control systems. Likewise Hartley is doing similar business over
at Vision Engravings.

Is the situation such that there is a whole bunch of industrial
systems out there, in active use and needing future upgrades,
that use the EP93xx?

Arnd has been nudging me to do DT conversion for EP93xx
so if there are many active industrial users of these
I should prioritize it, because these things have 20+ years
support cycles.

We also need to think about upholding support in GCC for
ARMv4(t) for the foreseeable future if there is a big web of
random deeply embedded systems out there that will need
updates.

Yours,
Linus Walleij
