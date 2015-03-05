From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Mar 2015 10:41:42 +0100
Subject: [PATCH 08/11] Documentation: bindings: move the Berlin pinctrl
 documentation
In-Reply-To: <1423671332-24580-9-git-send-email-antoine.tenart@free-electrons.com>
References: <1423671332-24580-1-git-send-email-antoine.tenart@free-electrons.com>
 <1423671332-24580-9-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <CACRpkdY5g4Xjtf0gRP2b2BjEmXRgorwDB8zFaUcGZbpwPGQE1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 5:15 PM, Antoine Tenart
<antoine.tenart@free-electrons.com> wrote:

> The Berlin pinctrl documentation was part of the Marvell Berlin SoC
> documentation because the Berlin pinctrl configuration was inside the
> chip and the system controllers. With the recent rework of the chip and
> system controller handling (now an MFD driver registers all sub-devices
> of the two soc and system controller nodes and each device has its own
> sub-node), the documentation of the Berlin pinctrl driver can be moved
> to the generic pinctrl documentation directory.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I tried applying the patch but it doesn't work. Rebase on v4.0-rc1 and
resend if you want me to apply it to the pinctrl tree.

Yours,
Linus Walleij
