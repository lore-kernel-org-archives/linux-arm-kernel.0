From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 5 Jul 2017 08:48:41 +0000
Subject: [PATCH V4 0/2] timer: add imx tpm timer support
In-Reply-To: <20170705162345.0000020e@huawei.com>
References: <1499222112-9988-1-git-send-email-aisheng.dong@nxp.com>
 <20170705162345.0000020e@huawei.com>
Message-ID: <AM3PR04MB306586EB2AFAD8F4B28BC4980D40@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jonathan Cameron [mailto:Jonathan.Cameron at huawei.com]
> Sent: Wednesday, July 05, 2017 4:24 PM
> To: A.s. Dong
> Cc: linux-kernel at vger.kernel.org; Jacky Bai; Anson Huang;
> daniel.lezcano at linaro.org; kernel at pengutronix.de; tglx at linutronix.de;
> shawnguo at kernel.org; linux-arm-kernel at lists.infradead.org;
> dongas86 at gmail.com
> Subject: Re: [PATCH V4 0/2] timer: add imx tpm timer support
> 
> On Wed, 5 Jul 2017 10:35:10 +0800
> Dong Aisheng <aisheng.dong@nxp.com> wrote:
> 
> > The Timer/PWM Module (TPM) supports input capture, output compare, and
> > the generation of PWM signals to control electric motor and power
> > management applications. The counter, compare and capture registers
> > are clocked by an asynchronous clock that can remain enabled in low
> > power modes. TPM can support global counter bus where one TPM drives
> > the counter bus for the others, provided bit width is the same.
> >
> > This patch only adds the timer support. PWM would be added later.
> Hi Dong,
> 
> Not relevant to this patch - just an observation!
> 
> Just came across this thread and took a look at the hardware. I see some
> of the timers (particularly the flextimers) support quadrature encoder
> modes.  Just thought I'd point you at some on going discussions on the
> IIO list (linux-iio at vger.kernel.org) trying to improve the interface for
> such devices.  Might be of interest (or not depending on whether support
> for that functionality is of interest!)
> 
> http://marc.info/?l=linux-iio&m=149904379731556&w=2
> 

Hi Jonathan,

Thanks for the info.
I will find time to check it later.

Regards
Dong Aisheng
