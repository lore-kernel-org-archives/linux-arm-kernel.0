From: zhangwm@marvell.com (Neil Zhang)
Date: Sun, 4 May 2014 23:28:03 -0700
Subject: [PATCH v4] ARM: perf: save/restore pmu registers in pm notifier
In-Reply-To: <5360FB07.5030407@arm.com>
References: <1398133596-29170-1-git-send-email-zhangwm@marvell.com>
 <20140422103642.GF7484@arm.com>
 <175CCF5F49938B4D99B2E3EF7F558EBE5507A3B59B@SC-VEXCH4.marvell.com>
 <20140423170821.GJ5649@arm.com>
 <175CCF5F49938B4D99B2E3EF7F558EBE5507A3C1F1@SC-VEXCH4.marvell.com>
 <5360FB07.5030407@arm.com>
Message-ID: <175CCF5F49938B4D99B2E3EF7F558EBE57AF37D469@SC-VEXCH4.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sudeep,

> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
> Sent: 2014?4?30? 21:31
> To: Neil Zhang; Will Deacon
> Cc: Sudeep Holla; linux at arm.linux.org.uk;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH v4] ARM: perf: save/restore pmu registers in pm notifier
> 
> Hi Neil,
> 
> On 30/04/14 03:21, Neil Zhang wrote:
> >
> >> -----Original Message-----
> >> From: Will Deacon [mailto:will.deacon at arm.com]
> 
> [...]
> 
> >>
> >> I think we need some input from the device-tree guys to see whether
> >> they would object to us solving this locally (in the PMU node) or not.
> >> Personally, I'd much prefer a general way to describe the need for
> >> pm-notifiers, but if that's not being looked at then we can cook
> >> something specifically for our needs.
> >>
> >
> > No input from device-tree guys :(
> 
> The device tree bindings for power domains is under discussion [1]

Thanks for the information.
But it currently for device only, core related stuff are not supported.
And is it really good to register power provider for core and let vfp / pmu etc to get it?

> 
> Regards,
> Sudeep
> 
> [1] https://lkml.org/lkml/2014/4/23/755


Best Regards,
Neil Zhang
