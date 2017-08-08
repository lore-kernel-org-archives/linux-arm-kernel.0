From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 8 Aug 2017 15:46:33 +0200 (CEST)
Subject: [PATCH 0/4] constify thermal_zone_of_device_ops structures
In-Reply-To: <1502199838.4296.64.camel@intel.com>
References: <1501965437-30730-1-git-send-email-Julia.Lawall@lip6.fr>
 <1502199838.4296.64.camel@intel.com>
Message-ID: <alpine.DEB.2.20.1708081546130.28470@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 8 Aug 2017, Zhang Rui wrote:

> On Sat, 2017-08-05 at 22:37 +0200, Julia Lawall wrote:
> > The thermal_zone_of_device_ops structures are only passed as the
> > fourth
> > argument to thermal_zone_of_sensor_register, which is declared as
> > const.
> > Thus the thermal_zone_of_device_ops structures themselves can be
> > const.
> >
> > Done with the help of Coccinelle.
>
> I still see the same problem in other thermal drivers, which is not
> covered by this patch set. Can we fix them all in one time?

OK.

julia
