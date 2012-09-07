From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Sep 2012 10:10:47 +0200
Subject: [PATCH 2/5] arm/dts: Add pinctrl driver entries for omap2/3/4
In-Reply-To: <20120906185824.1172.95748.stgit@muffinssi.local>
References: <20120906185615.1172.23588.stgit@muffinssi.local>
 <20120906185824.1172.95748.stgit@muffinssi.local>
Message-ID: <CACRpkdZOJURpX=NqAOemKiOXvKQp5brUqpkB7YOdZvAosHD2eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 6, 2012 at 8:58 PM, Tony Lindgren <tony@atomide.com> wrote:

> Add pinctrl driver entries for omap2+. These all use
> the generic pinctrl-single driver for the padconf
> registers.
>
> Note that as 2420 and 2430 have different padmux
> registers, we now need to include omap2420.dtsi from
> omap2420-h4.dts.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: devicetree-discuss at lists.ozlabs.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>

FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
