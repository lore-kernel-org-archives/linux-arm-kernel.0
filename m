From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 14 Feb 2018 09:38:53 +0000
Subject: [PATCH v2 0/8] Add support for PWM input capture on STM32
In-Reply-To: <5ade7f05-f5cc-e272-842c-22effa78b716@st.com>
References: <1516979499-3665-1-git-send-email-fabrice.gasnier@st.com>
 <5ade7f05-f5cc-e272-842c-22effa78b716@st.com>
Message-ID: <20180214093853.4sskffpd5iasswen@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Feb 2018, Fabrice Gasnier wrote:

> On 01/26/2018 04:11 PM, Fabrice Gasnier wrote:
> > This series adds support for capture to stm32-pwm driver.
> > Capture is based on DMAs.
> > - First two patches are precursor patches
> > - Subsequent two patches add support for requesting DMAs to MFD core
> > - Next three patches add support for capture to stm32-pwm driver
> > - This has been tested on stm32429i-eval board.
> > 
> > ---
> > Changes in v2:
> > - Abstract DMA handling from child driver: move it to MFD core
> > - Rework pwm capture routines to adopt this change
> > - Comment on optional dma support, beautify DMAs probe
> 
> Hi all,
> 
> Gentle ping for v2 driver review since DT Bindings has been reviewed by
> Rob and the series by Benjamin.

Best thing to do is collect the Acks you have and send the set out as
a [RESEND].

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
