From: robh@kernel.org (Rob Herring)
Date: Mon, 30 Jul 2018 11:23:06 -0600
Subject: [PATCH v3 1/2] clk: meson: add DT documentation for emmc clock
 controller
In-Reply-To: <e797412b-55db-6678-82ba-3a10ac99db9f@amlogic.com>
References: <20180712211244.11428-1-yixun.lan@amlogic.com>
 <20180712211244.11428-2-yixun.lan@amlogic.com>
 <20180724232917.GA27041@rob-hp-laptop>
 <e797412b-55db-6678-82ba-3a10ac99db9f@amlogic.com>
Message-ID: <CAL_JsqLrO+UMjhgSnaO+Ch-zpLj2-gjkuO=v1PRpMemYmcO2pQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 8:14 AM Yixun Lan <yixun.lan@amlogic.com> wrote:
>
>
> HI Rob
>
> On 07/25/2018 07:29 AM, Rob Herring wrote:
> > On Thu, Jul 12, 2018 at 09:12:43PM +0000, Yixun Lan wrote:
> >> Document the MMC sub clock controller driver, the potential consumer
> >> of this driver is MMC or NAND. Also add three clock bindings IDs which
> >> provided by this driver.
> >>
> >> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> >> ---
> >>  .../bindings/clock/amlogic,mmc-clkc.txt       | 31 +++++++++++++++++++
> >>  .../clock/amlogic,meson-mmc-clkc.h            | 16 ++++++++++
> >>  2 files changed, 47 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> >>  create mode 100644 include/dt-bindings/clock/amlogic,meson-mmc-clkc.h
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> >
>
> Thanks for the review!
>
> There is a discussion about dropping "meson-" prefix in the compatible
> string[1]
>
> So, I will send another version with the new compatible name adjusted
> from "amlogic,meson-axg-mmc-clkc" to "amlogic,axg-mmc-clkc"..
> probably also rename the dt-bindings header file to amlogc,mmc-clkc.h

Okay, you can keep my R-by.
