From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Sep 2017 17:20:29 +0100
Subject: [PATCH] arm64: dts: foundation-v8: Enable PSCI mode
In-Reply-To: <f0710af4-d414-1f2a-7d86-dd559a50171f@linaro.org>
References: <20170918153832.16356-1-daniel.thompson@linaro.org>
 <20170918161248.GB5106@leverpostej>
 <f0710af4-d414-1f2a-7d86-dd559a50171f@linaro.org>
Message-ID: <20170919162029.GJ30715@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 19, 2017 at 04:59:15PM +0100, Daniel Thompson wrote:
> On 18/09/17 17:12, Mark Rutland wrote:

> >Could we split spin-table / PSCI parts into separate dtsi files?
> >
> >e.g. have:
> >
> >* foundation-v8.dtsi
> >* foundation-v8-gicv{2,3}.dtsi
> >* foundation-v8-{psci,spin-table}.dtsi
> >
> >... and then combine those to build the dts files we want.
> 
> Will do.
> 
> >FWIW, with that:
> >
> >Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Talking about what we want... if it's all split out I might as well
> add a gicv2+psci DT as well. Will that still retain your Acked-by or
> do you want to see it first ;-) ?

Sure; that's fine by me. :)

Thanks,
Mark.
