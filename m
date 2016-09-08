From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 8 Sep 2016 09:05:57 +0530
Subject: [PATCH v2 1/2] Documentation: dt: add bindings for ti-cpufreq
In-Reply-To: <57D025E8.6030202@ti.com>
References: <20160901025328.376-1-d-gerlach@ti.com>
 <20160901025328.376-2-d-gerlach@ti.com>
 <20160907051215.GN27345@vireshk-i7> <57D025E8.6030202@ti.com>
Message-ID: <20160908033557.GQ27345@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-09-16, 09:36, Dave Gerlach wrote:
> On 09/07/2016 12:12 AM, Viresh Kumar wrote:
> >On 31-08-16, 21:53, Dave Gerlach wrote:
> >>+In 'operating-points-v2' table:
> >>+- compatible: Should be
> >>+	- 'operating-points-v2-ti-am3352-cpu' for am335x SoCs
> >>+	- 'operating-points-v2-ti-am4372-cpu' for am43xx SoCs
> >>+	- 'operating-points-v2-ti-dra7-cpu' for dra7xx/am57xx SoCs
> >
> >Why do you need SoC specific compatible here? Are you defining new
> >fields in OPP tables for your SoC ? How are the tables for your case
> >going to differ from the ones using "operating-points-v2" compatible
> >string?
> >
> 
> I thought you had suggested that I do this in your comments from v1, but I
> guess that was dependent on whether or not I put the properties I have
> inserted into the cpu node into the operating-points table instead.

Yes.

> I still
> have gotten no comments from any DT maintainers so I left it as is. I am
> still not sure if that is acceptable.

@Rob: Can you please share your views on the new properties being
added to the CPU node ?

-- 
viresh
