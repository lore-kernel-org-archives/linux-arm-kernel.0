From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Aug 2017 14:31:41 +0200
Subject: [PATCH 2/4] rtc: pl031: use devm_* for allocating memory and
 mapping resource
In-Reply-To: <E1dYKiF-0001kS-1w@rmk-PC.armlinux.org.uk>
References: <20170720231745.GE31807@n2100.armlinux.org.uk>
 <E1dYKiF-0001kS-1w@rmk-PC.armlinux.org.uk>
Message-ID: <CACRpkdarOfyYZnJeu5_tLsgfd+LTAOnDw5=gi59r-EG5M3Zmzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 21, 2017 at 1:18 AM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:

> Use the devm_* APIs for allocating memory and mapping the memory in
> the probe function to relieve the driver from having to deal with
> this in the cleanup paths.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
