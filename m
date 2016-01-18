From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Mon, 18 Jan 2016 01:31:58 +0000
Subject: [PATCH 2/2] regulator: add documentation for ACT8945A's
 regulator DT bindings
In-Reply-To: <20160115175905.GB6588@sirena.org.uk>
References: <1452218938-10621-1-git-send-email-wenyou.yang@atmel.com>
 <1452218938-10621-3-git-send-email-wenyou.yang@atmel.com>
 <20160115175905.GB6588@sirena.org.uk>
Message-ID: <B256D81BAE5131468A838E5D7A243641D63F1B1E@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: 2016?1?16? 1:59
> To: Yang, Wenyou <Wenyou.Yang@atmel.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>; Rob Herring <robh+dt@kernel.org>;
> Pawel Moll <pawel.moll@arm.com>; Mark Rutland <mark.rutland@arm.com>; Ian
> Campbell <ijc+devicetree@hellion.org.uk>; Kumar Gala <galak@codeaurora.org>;
> Ferre, Nicolas <Nicolas.FERRE@atmel.com>; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH 2/2] regulator: add documentation for ACT8945A's regulator
> DT bindings
> 
> On Fri, Jan 08, 2016 at 10:08:58AM +0800, Wenyou Yang wrote:
> 
> > +Optional properties:
> > +- active-semi,vsel-high: Indicates if the VSEL pin is set to logic-high.
> > +  If this property is missing, assume the VSEL pin is set to logic-low.
> 
> Wouldn't such a pin normally be connected to a GPIO for runtime control
> - why is it expected to be tied statically all the time?

On the reference board, it is connected to the VSYS_5V statically.

Yes, it should be connected to a GPIO, it should be controllable at the necessary time.


Best Regards,
Wenyou Yang 
