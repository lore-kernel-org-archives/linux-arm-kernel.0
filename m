From: arun.murthy@stericsson.com (Arun MURTHY)
Date: Fri, 1 Oct 2010 05:25:54 +0200
Subject: [PATCH 1/7] pwm: Add pwm core driver
In-Reply-To: <AANLkTingb8ox5h5rN1YrxONibfrWLicoiS6yqKf_v5bJ@mail.gmail.com>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
	<1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>
	<4CA1AD2B.8000905@metafoo.de>
	<F45880696056844FA6A73F415B568C69532DC2FB6B@EXDCVYMBSTM006.EQ1STM.local>
	<4CA1BC16.3020702@metafoo.de>
	<F45880696056844FA6A73F415B568C69532DC2FC60@EXDCVYMBSTM006.EQ1STM.local>
	<4CA25841.4090702@metafoo.de>
	<F45880696056844FA6A73F415B568C69532DC8B7E4@EXDCVYMBSTM006.EQ1STM.local>
	<AANLkTingb8ox5h5rN1YrxONibfrWLicoiS6yqKf_v5bJ@mail.gmail.com>
Message-ID: <F45880696056844FA6A73F415B568C69532DCF32BC@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Trilok,

> Hi Arun,
> 
> Adding Bill Gatliff (anyway, CC list already crowded)
> 
> On Wed, Sep 29, 2010 at 10:19 AM, Arun MURTHY
> <arun.murthy@stericsson.com> wrote:
> >> Arun MURTHY wrote:
> >> >>>> Shouldn't PWM_DEVICES select HAVE_PWM?
> >> >>>
> >> >>> No not required, the entire concept is to remove HAVE_PWM and
> use
> >> >> PWM_CORE.
> 
> There is already nice and clean framework written by Bill for PWM, if
> you grep the LKML and linux-embedded mailing list archive then you
> will get his patches, and it seems that he had promised to send the
> updated version few week back, but not heard from him (may be because
> he was travelling as per FB status).
> 
> Please evaluate that framework too.
> 
Thanks for this information, I did search in linux-embedded mailing list
archive. Below are my views on that patch set.
Many of the functions that has been defined in pwm core driver
written by Bill Gatliff is not being used by the most of the pwm drivers
except Atmel PWM driver. I rather felt the pwm core driver was an attempt
made to generalize the Atmel pwm driver.
And moreover this was posted long back somewhere in the beginning of this
year i.e Feb and the thread is dead thereafter.

This patch has been submitted focusing all the existing pwm drivers and
only these are the functions that are being used by pwm drivers.
This patch set also included patch to align all the existing pwm driver
with the pwm core driver.
So it is an attempt to generalize most of the pwm drivers and
conclude with a pwm core driver.

Thanks and Regards,
Arun R Murthy
-------------
