From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 12 Dec 2012 10:40:21 +0200
Subject: [PATCH V3 2/3] dmaengine: dw_dmac: Enhance device tree support
In-Reply-To: <CAKohpo=FjZuMOC-wuNc3q_FXbk546ttCLr55GkW9AL0Tz-HoBA@mail.gmail.com>
References: <3100e691db3f94c22afd98b609a1568d7e70dfe7.1350360935.git.viresh.kumar@linaro.org>
 <169edae67b9a051ca7448e5b62c3cd2c5c1db470.1350360935.git.viresh.kumar@linaro.org>
 <201212102208.52347.arnd@arndb.de>
 <CAKohpo=FjZuMOC-wuNc3q_FXbk546ttCLr55GkW9AL0Tz-HoBA@mail.gmail.com>
Message-ID: <1355301621.31620.66.camel@smile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-12-12 at 08:30 +0530, Viresh Kumar wrote: 
> > * It requires slave drivers to know that they are using the dw_dmac
> >   driver and pass a pointer to dw_generic_filter, which is not
> >   generic at all
> >
> > * It requires the dmac node to have information about all slaves
> >
> > There are also some minor issues, such as the naming of DT
> > properties, but the above need to be resolved first.
> 
> I saw the binding document and it looks it can be applied to dw_dmac
> too, as there is nothing special for it.
> 
> The question is how? We are already late for merge window and this
> one is queued. Supplying a new patch, getting it reviewed/tested and
> being pulled by Linus is not so easy :)
> 
> Two ways:
> - Keep it as is, and i will fix it separately and quickly
> - Drop it :(
Will we survive if the patch is in mainline? I mean how big the impact
of it is?


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
