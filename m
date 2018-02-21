From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed, 21 Feb 2018 20:25:26 +0530
Subject: [PATCH 08/10] gpio: Add gpio driver for Actions OWL S900 SoC
In-Reply-To: <CAOFm3uEYhMxMz5QHDhOtpzEsrwJPrOdqLbGWTqveuNMtR_FVWA@mail.gmail.com>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
 <20180217204433.3095-9-manivannan.sadhasivam@linaro.org>
 <CAOFm3uEYhMxMz5QHDhOtpzEsrwJPrOdqLbGWTqveuNMtR_FVWA@mail.gmail.com>
Message-ID: <20180221145526.6kr7kx5dwg5lzyvg@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,
On Tue, Feb 20, 2018 at 08:55:57AM +0100, Philippe Ombredanne wrote:
> Manivannan,
> 
> On Sat, Feb 17, 2018 at 9:44 PM, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > Add gpio driver for Actions Semi OWL family S900 SoC. Set of registers
> > controlling the gpio shares the same register range with pinctrl block.
> >
> > GPIO registers are organized as 6 banks and each bank controls the
> > maximum of 32 gpios.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> <snip>
> 
> > --- /dev/null
> > +++ b/drivers/gpio/gpio-owl.c
> > @@ -0,0 +1,258 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> 
> <snip>
> 
> > +MODULE_LICENSE("GPL v2");
> 
> Please sync this with your SPDX id above. nodule.h has the doc on the
> meaning of MODULE_LICENSE macros.
> Here you have stated a combo of GPL-2.0 and GPL-2.0 or later
> 
Sorry. It should be MODULE_LICENSE("GPL"). Will get it fixed in next revision.

Thanks,
Mani
> -- 
> Cordially
> Philippe Ombredanne
