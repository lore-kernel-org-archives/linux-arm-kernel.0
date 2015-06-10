From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 14:01:23 +0200
Subject: [PATCH 23/34] pinctrl: mvebu: armada-xp: rename spi to spi0
In-Reply-To: <1433868446-11028-24-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-24-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdbYmsbKJSs9h=Rs2iMrAhYQ+WV5L5xCZYvgmaJar4gEtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 6:47 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> After updating to the latest Armada XP datasheet, we discovered that
> there is a second SPI bus accessible from the MPP pins, called 'spi1'.
>
> In order to be consistent with other SoCs having two SPI busses, this
> commit renames the functions of the first SPI bus to 'spi0' instead of
> just 'spi'.
>
> This commit obviously breaks the DT backward compatibility for the
> people using the "spi" function name in their Device Tree.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
