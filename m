From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Fri, 13 Jan 2017 08:47:37 +0000
Subject: [PATCHv5 3/8] rtc: add STM32 RTC driver
In-Reply-To: <20170113003840.u6uxt7u4qsit3oqt@piout.net>
References: <1484142403-11556-1-git-send-email-amelie.delaunay@st.com>
 <20170113003840.u6uxt7u4qsit3oqt@piout.net>
Message-ID: <be3a19059b2e4e0a9bfb8d0c3292dac4@SFHDAG3NODE2.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

> This didn't apply cleanly, please check rtc-next. I don't think I made any mistake
> as the issue was only in Kconfig. You probably based your patches on 4.9
> instead of 4.10-rc1.
Sorry for this inconvenience. You're right, my patches were based on 4.9 to be tested on stm32f4 family.
No mistake found in your conflict resolution in Kconfig.

I'm going to send a new patch to fix warnings introduced by my driver on rtc-next.

Regards,
Amelie

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni at free-electrons.com]
> Sent: vendredi 13 janvier 2017 01:39
> To: Amelie DELAUNAY <amelie.delaunay@st.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Maxime
> Coquelin <mcoquelin.stm32@gmail.com>; Alexandre TORGUE
> <alexandre.torgue@st.com>; Russell King <linux@armlinux.org.uk>; rtc-
> linux at googlegroups.com; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Gabriel FERNANDEZ
> <gabriel.fernandez@st.com>
> Subject: Re: [PATCHv5 3/8] rtc: add STM32 RTC driver
> 
> On 11/01/2017 at 14:46:43 +0100, Amelie Delaunay wrote :
> > This patch adds support for the STM32 RTC.
> >
> > Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> > ---
> >  drivers/rtc/Kconfig     |  11 +
> >  drivers/rtc/Makefile    |   1 +
> >  drivers/rtc/rtc-stm32.c | 727
> > ++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 739 insertions(+)
> >  create mode 100644 drivers/rtc/rtc-stm32.c
> >
> 
> This didn't apply cleanly, please check rtc-next. I don't think I made any mistake
> as the issue was only in Kconfig. You probably based your patches on 4.9
> instead of 4.10-rc1.
> 
> 
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
