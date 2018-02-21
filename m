From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed, 21 Feb 2018 20:26:47 +0530
Subject: [PATCH 04/10] pinctrl: actions: Add Actions S900 pinctrl driver
In-Reply-To: <CAOFm3uF=n+_TJUAuXh-KihA6gprJaLMiH+y6b3y-5QpcGqGNtg@mail.gmail.com>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
 <20180217204433.3095-5-manivannan.sadhasivam@linaro.org>
 <CAOFm3uF=n+_TJUAuXh-KihA6gprJaLMiH+y6b3y-5QpcGqGNtg@mail.gmail.com>
Message-ID: <20180221145646.i4v2ez5uwscy3gm2@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,
On Tue, Feb 20, 2018 at 08:53:22AM +0100, Philippe Ombredanne wrote:
> Dear Manivannan,
> 
> On Sat, Feb 17, 2018 at 9:44 PM, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > Add pinctrl driver for Actions Semi S900 SoC. The driver supports
> > pinctrl, pinmux and pinconf functionalities through a range of registers
> > common to both gpio driver and pinctrl driver.
> >
> > Pinmux functionality is available only for the pin groups while the
> > pinconf functionality is available for both pin groups and individual
> > pins.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> 
> <snip>
> 
> 
> > --- /dev/null
> > +++ b/drivers/pinctrl/actions/pinctrl-s900.c
> > @@ -0,0 +1,2536 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> 
> <snip>
> 
> > +MODULE_LICENSE("GPL v2");
> 
> This does not match your license above. Per module.h "GPL v2" means
> GPL-2.0 where you license above GPL-2.0+ means or later
> 
Should be MODULE_LICENSE("GPL"). Will get it fixed in next revision.

Thanks,
Mani
> -- 
> Cordially
> Philippe Ombredanne
