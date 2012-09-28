From: afzal@ti.com (Mohammed, Afzal)
Date: Fri, 28 Sep 2012 04:52:53 +0000
Subject: [PATCH v7 08/11] ARM: OMAP2+: gpmc: generic timing calculation
In-Reply-To: <50646DBC.5090809@ti.com>
References: <cover.1348058726.git.afzal@ti.com>
 <6b20c05230f22380802936f83377e94823488fa8.1348058726.git.afzal@ti.com>
 <5063C6E6.50109@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9EA17D@DBDE01.ent.ti.com>
 <50646DBC.5090809@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9F5240@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Thu, Sep 27, 2012 at 20:46:12, Hunter, Jon wrote:
> On 09/27/2012 05:07 AM, Mohammed, Afzal wrote:

> >> Or maybe should the timings be grouped as ...
> >>
> >> General
> >> Read Async
> >> Read Async Address/Data Multiplexed
> >> Read Sync
> >> Read Sync Address/Data Multiplexed
> >> Write Async
> >> Write Async Address/Data Multiplexed
> >> Write Sync
> >> Write Sync Address/Data Multiplexed
> >>
> >> There may be some duplication but it will be clear where things like ADV
> >> timing applies.
> > 
> > I would prefer to keep it concise, but no strong opinion on it, if you
> > prefer as above, I will change it.
> 
> I think that if these represent the main use-case configurations this
> could add some value.

Ok

> >>> +	gpmc_convert_ps_to_ns(gpmc_t);
> > 
> >> I am wondering if we could avoid this above function and then ...
> > 
> > This will be removed once it is confirmed that all the peripherals
> > using custom runtime calculation can work with this generic
> > routine. Then all calculation would be purely in ps.
> 
> Ok, great. May be add a TODO here to make this clear that this is temporary.

Sure

Regards
Afzal
