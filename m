From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Thu, 14 Jan 2016 08:07:40 +0000
Subject: [PATCH v2 1/2] regulator: act8945a: add regulator driver for
 ACT8945A
In-Reply-To: <87egdk39ji.fsf@dell.be.48ers.dk>
References: <1452586629-1117-1-git-send-email-wenyou.yang@atmel.com>
 <1452586629-1117-2-git-send-email-wenyou.yang@atmel.com>
 <87oacp5zl7.fsf@dell.be.48ers.dk>
 <B256D81BAE5131468A838E5D7A243641D63EBC6E@penmbx01>
 <87egdk39ji.fsf@dell.be.48ers.dk>
Message-ID: <B256D81BAE5131468A838E5D7A243641D63EBEC7@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Peter Korsgaard [mailto:jacmet at gmail.com] On Behalf Of Peter Korsgaard
> Sent: 2016?1?14? 15:28
> To: Yang, Wenyou <Wenyou.Yang@atmel.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> Rob Herring <robh+dt@kernel.org>; Pawel Moll <pawel.moll@arm.com>; Mark
> Rutland <mark.rutland@arm.com>; Ian Campbell <ijc+devicetree@hellion.org.uk>;
> Kumar Gala <galak@codeaurora.org>; Krzysztof Kozlowski
> <k.kozlowski@samsung.com>; devicetree at vger.kernel.org; Ferre, Nicolas
> <Nicolas.FERRE@atmel.com>; linux-kernel at vger.kernel.org; Javier Martinez
> Canillas <javier@dowhile0.org>; Lee Jones <lee.jones@linaro.org>; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v2 1/2] regulator: act8945a: add regulator driver for
> ACT8945A
> 
> >>>>> "Yang," == Yang, Wenyou <Wenyou.Yang@atmel.com> writes:
> 
>  >> Isn't the regulator part of the act8945a identical to act8865? Can't we just use
> the  >> existing act8865-regulator.c driver? (E.G. support 8865 variant in the mfd
> driver,  >> but only register the regulator sub device?)
> 
>  > Yes, the regulator part of the act8945a is identical to act8865.
> 
>  > But the act8865-regulator driver is a struct i2c_driver, and the mfd  > sub-
> device driver is a platform_driver driver, it is not easy to use  > it.
> 
> But the mfd driver could support the act8865 variant as well (by only registering
> the regulator mfd cell).

I still don't understand.

The MFD sub device is registered as a platform device, the existing act8865 driver is registered as an i2c_driver. How do they match? :)

Could you point out which exiting driver for me to reference.  Thank you!


Best Regards,
Wenyou Yang
