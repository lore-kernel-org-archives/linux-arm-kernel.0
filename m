From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Jun 2017 11:21:18 +0200
Subject: [PATCH v3 3/9] pinctrl: avoid PLAT_ORION dependency
In-Reply-To: <58b227242d015c9a9db62bfd331be351037b1054.1497281623.git-series.gregory.clement@free-electrons.com>
References: <cover.d003a5e862e6d732d901a61d1765a349c9a89eef.1497281623.git-series.gregory.clement@free-electrons.com>
 <58b227242d015c9a9db62bfd331be351037b1054.1497281623.git-series.gregory.clement@free-electrons.com>
Message-ID: <CACRpkdYMMRaUEFSVV3f60tTaCGyV8hmD6u+TOavAJnho-=Fb1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 5:34 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> Armada 8040 also needs orion pinctrl, and as these symbols are only
> selected, there's no need to make them depend on PLAT_ORION.
>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
