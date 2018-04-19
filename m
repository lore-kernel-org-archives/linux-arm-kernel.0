From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Thu, 19 Apr 2018 14:14:17 +0000
Subject: [PATCH 0/4] Various fixes on STM32 RTC
In-Reply-To: <20180419134321.GF7369@piout.net>
References: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
 <20180419134321.GF7369@piout.net>
Message-ID: <d2d1897e40834a1c84fc1e64309e2c3f@GPXDAG3NODE5.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry for that! I take note of your new email address. Thanks for your highlight.

Regards,
Amelie

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni at bootlin.com]
> Sent: jeudi 19 avril 2018 15:43
> To: Amelie DELAUNAY <amelie.delaunay@st.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Maxime
> Coquelin <mcoquelin.stm32@gmail.com>; Alexandre TORGUE
> <alexandre.torgue@st.com>; linux-rtc at vger.kernel.org;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org
> Subject: Re: [PATCH 0/4] Various fixes on STM32 RTC
> 
> Hi,
> 
> Both series were not sent to the correct email address. I would suggest
> rebasing on top of v4.17-rc1 ;). No need to resend just for that.
> 
> On 19/04/2018 15:21:39+0200, Amelie Delaunay wrote:
> > This series makes some corrections on STM32 RTC:
> > - update copyright and adopt SPDX identifier
> > - fix alarm interrupt flags
> > - rework DBP (Disable Backup domain Protection) management.
> >
> > This series is a preamble to the serie which will introduce next STM32
> > RTC version.
> >
> > Amelie Delaunay (4):
> >   rtc: stm32: fix copyright and adopt SPDX identifier
> >   rtc: stm32: fix alarm interrupt flags by removing IRQF_TRIGGER_RISING
> >   dt-bindings: rtc: update stm32-rtc documentation for st,syscfg
> >     property
> >   rtc: stm32: get DBP register and mask from DT st,syscfg property
> >
> >  .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 10 ++--
> >  drivers/rtc/rtc-stm32.c                            | 68 +++++++++++++---------
> >  2 files changed, 47 insertions(+), 31 deletions(-)
> >
> > --
> > 2.7.4
> >
> 
> --
> Alexandre Belloni, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
