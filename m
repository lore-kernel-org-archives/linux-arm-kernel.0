From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 03 Oct 2017 13:44:49 +0200
Subject: [PATCH] PM: ARM: locomo: Drop suspend and resume bus type
 callbacks
In-Reply-To: <CAPDyKFrkUW7S7hkEsYH9UWex3F=1QHFLozxyMey1e+XT2a8JGg@mail.gmail.com>
References: <2826985.0zUqx1lpzM@aspire.rjw.lan>
 <CAPDyKFrkUW7S7hkEsYH9UWex3F=1QHFLozxyMey1e+XT2a8JGg@mail.gmail.com>
Message-ID: <38658124.i1yAOWmsJn@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, October 3, 2017 10:09:21 AM CEST Ulf Hansson wrote:
> On 26 September 2017 at 22:45, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > None of the locomo drivers in the tree implements the suspend and
> > resume callbacks from struct locomo_driver, so drop them and drop
> > the corresponding callbacks from locomo_bus_type.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> FWIW:
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Do you also plan to convert the locomo_device_driver (platform_driver)
> to be converted to the modern PM callbacks for suspend/resume?

Yes, I do, but that later. :-)

Thanks,
Rafael
