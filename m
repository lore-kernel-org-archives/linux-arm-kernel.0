From: B47053@freescale.com (Xiubo Li-B47053)
Date: Mon, 2 Sep 2013 02:18:19 +0000
Subject: [PATCH 4/4] Documentation: Add device tree bindings for
 Freescale FTM PWM
In-Reply-To: <5EFBF478-CFCC-4E66-A279-25F4A338B05B@kernel.crashing.org>
References: <1377054462-6283-1-git-send-email-Li.Xiubo@freescale.com>
 <1377054462-6283-5-git-send-email-Li.Xiubo@freescale.com>
 <5EFBF478-CFCC-4E66-A279-25F4A338B05B@kernel.crashing.org>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F827F480B@039-SN2MPN1-011.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH 4/4] Documentation: Add device tree bindings for
> Freescale FTM PWM
> 
> Should have at least something w/regards to a commit message.
> 

I have sent a V2 patch and have added it.


> > +  used to encode the polarity of PWM output. Set bit 0 of the third
> > +in PWM
> > +  specifier to 1 for inverse polarity & set to 0 for normal polarity.
> > +- fsl,pwm-clk-ps: the ftm0 pwm clock's prescaler, divide-by 2^n(n = 0
> ~ 7).
> > +- fsl,pwm-cpwm: Center-Aligned PWM (CPWM) mode.
> 
> Should describe this in more detail, what does the value actually mean
> for what modes there are?
> 

It's maybe a very useful feature for FTM core, but for PWM is not.
This isn't needed any more for PWM, and in V2 patch I have removed CPWM mode.

> > +- fsl,pwm-number: the number of PWM devices, and is must equal to the
> > +number
> > +  of "fsl,pwm-channels".
> 
> If they must be equal why do we need both?
> 

I have replaced both of them too in V2.

> > +- fsl,pwm-channels: the channels' order which is be used for pwm in
> > +ftm0
> > +  module, and they must be one or some of 0 ~ 7, because the ftm0
> > +only has
> > +  8 channels can be used.
> > +- for very channel, the revlatived the pinctrl should be at least two
> > +state
> 
> revlatived?
> 

This too.

--
Best Regards.
Xiubo
