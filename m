From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Aug 2017 11:34:32 +0200
Subject: [PATCH] gpio: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-23-robh@kernel.org>
References: <20170718214339.7774-23-robh@kernel.org>
Message-ID: <CACRpkdbwoT=+6wdm3Xyfj58--Oz_55_ymmjX=tY60behsWc7CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 11:43 PM, Rob Herring <robh@kernel.org> wrote:

> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Tien Hock Loh <thloh@altera.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Gregory Fong <gregory.0xf0@gmail.com>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: bcm-kernel-feedback-list at broadcom.com
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: "S?ren Brinkmann" <soren.brinkmann@xilinx.com>
> Cc: linux-gpio at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org

Patch applied.

Yours,
Linus Walleij
