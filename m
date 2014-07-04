From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 04 Jul 2014 17:43:22 +0900
Subject: [PATCH 00/17] ARM: S5P64X0, S5PC100: no more support in mainline
In-Reply-To: <CAK5sBcHbs1ZSu=ZTWvEOeWO-kTCBh1OjTJc-YYxQzgV5QGOLNw@mail.gmail.com>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
 <53B4494B.1030909@samsung.com> <53B48BCB.4010308@samsung.com>
 <CAK5sBcHbs1ZSu=ZTWvEOeWO-kTCBh1OjTJc-YYxQzgV5QGOLNw@mail.gmail.com>
Message-ID: <033301cf9764$032390e0$096ab2a0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sachin Kamat wrote:
> 
> Hi Kukjin,
> 
Hi,

> On Thu, Jul 3, 2014 at 4:16 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > On 07/03/14 03:02, Tomasz Figa wrote:
> >>
> >> Hi Kukjin,
> >>
> > Hi,
> >
> >
> >> On 30.06.2014 23:32, Kukjin Kim wrote:
> >>>
> >>> This series removes S5P64X0 and S5PC100 related codes in mainline,
> >>> because no more user now. And if its supporting is required later,
> >>> it will be done with using device tree.
> >>>
> >>> [PATCH 01/17] ARM: S5P64X0: no more support S5P6440 and S5P6450 SoCs
> >>> [PATCH 02/17] gpio: samsung: remove s5p64x0 related gpio codes
> >>> [PATCH 03/17] spi: s3c64xx: remove s5p64x0 related spi codes
> >>> [PATCH 04/17] ASoC: samsung: no more support for S5P6440 and S5P6450
> >>> [PATCH 05/17] pwm: samsung: remove s5p64x0 related pwm codes
> >>> [PATCH 06/17] video: fbdev: s3c-fb: remove s5p64x0 related fimd
> >>> [PATCH 07/17] serial: samsung: no more support for S5P6440 and
> >>> [PATCH 08/17] ARM: S5PC100: no more support S5PC100 SoC
> >>> [PATCH 09/17] gpio: samsung: remov s5pc100 related gpio codes
> >>> [PATCH 10/17] spi: s3c64xx: remove s5pc100 related spi codes
> >>> [PATCH 11/17] pwm: samsung: remove s5pc100 related pwm codes
> >>> [PATCH 12/17] serial: samsung: no more support for S5PC100 SoC
> >>> [PATCH 13/17] ata: pata_samsung_cf: removes s5pc100 related ata
> >>> [PATCH 14/17] mtd: onenand: remove s5pc100 related onenand codes
> >>> [PATCH 15/17] video: fbdev: s3c-fb: remove s5pc100 related fimd and
> >>> [PATCH 16/17] [media] exynos4-is: removes s5pc100 related fimc codes
> >>> [PATCH 17/17] ASoC: Samsung: remove s5pc100 related codes
> >>
> >>
> >> Thanks for this series.
> >>
> >> Just letting you know that I have rebased my s5pv210 DT migration series
> >> on top of this and will be sending the patches after some more testing.
> >>
> > Just note since I've missed one more change in the series, I amended it just
> > now but it should be fine with your series I think.
> >
> > Please see v3.17-next/cleanup-s5p branch.
> 
> Can you please push out the other patches that you applied last week?
> 
You mean whole patches in this series? OK, I will in this weekend.
Note, as you know, missing patches in my tree are handled by other maintainer.

Thanks,
Kukjin
