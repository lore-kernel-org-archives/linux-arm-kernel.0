From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 11:12:03 +0200
Subject: [PATCH 15/34] pinctrl: mvebu: armada-39x: align NAND pin naming
In-Reply-To: <1433868446-11028-16-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-16-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdYWGFY4KH=4Afwc5ShuFOJyHcpBFb8dctCU-CPPvdxxJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 6:47 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> All SoCs use "nand" to designate NAND pins, only Armada 39x is using
> "nd", which is not consistent. This commit fixes that by renaming the
> corresponding functions.
>
> It also changes the subnames from rbn0/rbn1 to rb0/rb1, to respect the
> convention used everywhere that we don't encode the 'n' part of signal
> names.
>
> While this commit changes the main name of function, therefore
> potentially breaking the DT compatibility, this is not a problem since
> Armada 39x is a brand new SoC which isn't used in production yet.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
