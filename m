From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 9 Jun 2013 13:28:55 +0800
Subject: [PATCH 3/4] pinctrl: single: omap: Add SoC specific module for
 wake-up events
In-Reply-To: <20130607205044.16513.27675.stgit@localhost>
References: <20130607203936.16513.57494.stgit@localhost>
 <20130607205044.16513.27675.stgit@localhost>
Message-ID: <CAN1soZxC0QLGrhm=ZZpny0kDBnyv9ikZaw7gS+aLmbtPpd0pKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 8, 2013 at 4:50 AM, Tony Lindgren <tony@atomide.com> wrote:
> For wake-up events from deeper idle modes we need to check the
> configured padconf registers for the wake-up bit and then call
> the related interrupt handler.
>
> Done in collaboration with Roger Quadros <rogerq@ti.com>.
>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: devicetree-discuss at lists.ozlabs.org
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/pinctrl/Makefile                          |    3
>  drivers/pinctrl/pinctrl-single-omap.c             |  287 +++++++++++++++++++++
>  include/linux/platform_data/pinctrl-single-omap.h |    4
>  3 files changed, 293 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pinctrl/pinctrl-single-omap.c
>  create mode 100644 include/linux/platform_data/pinctrl-single-omap.h
>

The hardware behavior likes PXA3xx.

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Regards
Haojian
