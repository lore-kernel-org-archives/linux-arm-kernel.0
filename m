From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 09:14:39 +0200
Subject: [PATCH v2 07/10] Documentation: bindings: move the Berlin pinctrl
 documentation
In-Reply-To: <1425654328-26298-8-git-send-email-antoine.tenart@free-electrons.com>
References: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
 <1425654328-26298-8-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <CACRpkdZ8k9OVCPG1AMCJG9UMtL6Q2tCd+syKXR10F=E8ifuQDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 6, 2015 at 4:05 PM, Antoine Tenart
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

Yours,
Linus Walleij
