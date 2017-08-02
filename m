From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Aug 2017 14:33:15 +0200
Subject: [PATCH 4/4] rtc: pl031: make interrupt optional
In-Reply-To: <E1dYKiP-0001kg-BQ@rmk-PC.armlinux.org.uk>
References: <20170720231745.GE31807@n2100.armlinux.org.uk>
 <E1dYKiP-0001kg-BQ@rmk-PC.armlinux.org.uk>
Message-ID: <CACRpkdY-FCH8Fhaoi_CTqDUNGYTtFy247Q6jwPh6omQrspkgvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 21, 2017 at 1:18 AM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:

> On some platforms, the interrupt for the PL031 is optional.  Avoid
> trying to claim the interrupt if it's not specified.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
