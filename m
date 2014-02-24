From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Feb 2014 10:52:12 +0100
Subject: [PATCH 1/2] pinctrl: mvebu: add pin-muxing driver for the Marvell
 Armada 375
In-Reply-To: <1392051896-19178-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392051896-19178-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392051896-19178-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdb_j2bxOHK_EB5b44Z3dzXpgzUFh7EQdf8xYWSbk11KGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 6:04 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> The Marvell Armada 375 is a new ARM SoC from Marvell, part of the
> mvebu family, but using a Cortex-A9 CPU core. In terms of pin-muxing,
> it is similar to Armada 370 and XP for the register layout, only
> different in the number of available pins and their
> functions. Therefore, we simply use the existing
> drivers/pinctrl/mvebu/ infrastructure, with no other changes that the
> list of pins and corresponding functions.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Sure, patch applied.

Yours,
Linus Walleij
