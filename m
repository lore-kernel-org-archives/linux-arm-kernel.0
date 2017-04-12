From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 12 Apr 2017 14:34:54 +0100
Subject: [PATCH V2] clk: hi6220: Add the hi655x's pmic clock
In-Reply-To: <c1dba250-a60c-febc-a5c3-5ba645a61ce0@linaro.org>
References: <1491683412-12237-1-git-send-email-daniel.lezcano@linaro.org>
 <20170411140613.jvhzsvrxa4evwxjh@dell> <20170411211936.GT2078@mai>
 <20170412080038.kk4vrjhvr3eao26q@dell>
 <c1dba250-a60c-febc-a5c3-5ba645a61ce0@linaro.org>
Message-ID: <20170412133454.cfywpavifwpoetwo@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Apr 2017, Daniel Lezcano wrote:

> On 12/04/2017 10:00, Lee Jones wrote:
> > On Tue, 11 Apr 2017, Daniel Lezcano wrote:
> > 
> >> On Tue, Apr 11, 2017 at 03:06:13PM +0100, Lee Jones wrote:
> >>> On Sat, 08 Apr 2017, Daniel Lezcano wrote:
> >>>
> >>>> The hi655x multi function device is a PMIC providing regulators.
> >>>>
> >>>> The PMIC also provides a clock for the WiFi and the Bluetooth, let's implement
> >>>> this clock in order to add it in the hi655x MFD and allow proper wireless
> >>>> initialization.
> >>>>
> >>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> [ ... ]
> 
> >> Do you want to drop it from your tree or shall I resubmit a V3 without the mfd
> >> change?
> > 
> > The latter please.
> 
> Ok.
> 
> What about the DT binding change?

If I haven't merged it already, you'll need to re-send that
(separately) too.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
