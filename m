From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 17 Mar 2018 22:34:22 +0000
Subject: [PATCH 0/2] iio: stm32-dfsdm-adc: fix filter & rate setting
In-Reply-To: <1ddfcfad-f06e-738f-53cf-11dc56e61da1@st.com>
References: <1520950986-23116-1-git-send-email-fabrice.gasnier@st.com>
 <1ddfcfad-f06e-738f-53cf-11dc56e61da1@st.com>
Message-ID: <20180317223422.1a08a254@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Mar 2018 10:10:09 +0100
Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:

> Hello,
> 
> For the series:
> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Both applied and marked for stable (as I'm not sure exactly when this will hit
mainline and it may be after the next merge window)

Thanks,

Jonathan

> 
> Thanks,
> Arnaud
> 
> On 03/13/2018 03:23 PM, Fabrice Gasnier wrote:
> > This series brings fixes to STM32 DFSDM ADC driver.
> > 
> > Fabrice Gasnier (2):
> >   iio: adc: stm32-dfsdm: fix successive oversampling settings
> >   iio: adc: stm32-dfsdm: fix sample rate for div2 spi clock
> > 
> >  drivers/iio/adc/stm32-dfsdm-adc.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >   
