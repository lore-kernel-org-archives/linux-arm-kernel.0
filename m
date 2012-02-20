From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 20 Feb 2012 11:40:13 +0200
Subject: [2.6.39.3] [MX25] oops in driver_register for ADC touchscreen
 support (imx_adc_ts)
In-Reply-To: <50e2a71500444a5e1b951e5856d474bf@mail.fqingenieria.es>
References: <50e2a71500444a5e1b951e5856d474bf@mail.fqingenieria.es>
Message-ID: <20120220094013.GA9921@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi joancarles,

On Mon, Feb 20, 2012 at 10:15:42AM +0100, joancarles wrote:
> We're trying to get our ADC working (actually generic 4-way
> touchscreen support via ADC) on a custom PCB using the i.MX25
> infrastructure. It seems that there are not a lot of people out
> there, who have tried the Freescale implementation (based on their
> latest kernel drop: 2.6.31) of the ADC driver for touchscreen
> support. Freescale's support with regard to kernel development for
> out-of-tree implementation, somewhat understandably, has so far been
> close to non-existent.

This list is for mainline kernel only. You should contact Freescale for 
support for out of tree drivers in their kernel code. Unfortunately, it seems 
that Freescale has no interest in mainline kernel support for i.MX25.

You may try a newer kernel drop from Freescale, based on 2.6.38 (tagged 
rel_imx_2.6.38_11.11.01). Get it from 
http://opensource.freescale.com/git?p=imx/linux-2.6-imx.git;a=summary.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
