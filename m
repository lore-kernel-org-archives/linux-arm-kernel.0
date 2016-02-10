From: a0393675@ti.com (Keerthy)
Date: Wed, 10 Feb 2016 09:07:37 +0530
Subject: [PATCH 0/3] arm: dts: DRA7: Add IVA and DSPEVE thermal domain data
In-Reply-To: <20160209215326.GC27284@localhost.localdomain>
References: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
 <20160208195704.GW19432@atomide.com> <56B95EF7.9080107@ti.com>
 <20160209215326.GC27284@localhost.localdomain>
Message-ID: <56BAB081.5040005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 10 February 2016 03:23 AM, Eduardo Valentin wrote:
> On Tue, Feb 09, 2016 at 09:07:27AM +0530, Keerthy wrote:
>>
>>
>> On Tuesday 09 February 2016 01:27 AM, Tony Lindgren wrote:
>>> * Keerthy <j-keerthy@ti.com> [160208 01:19]:
>>>> OMAP5 has 3 thermal zones cpu, core and multimedia.
>>>> On the other hand DRA7 has 5 thermal zones cpu, gpu, core, dspeve
>>>> and iva. Currently cpu, core and multimedia are being added via dt
>>>> and the other 2 are getting added via kernel. Add the missing thermal
>>>> domains in dt so as give the correct trip numbers, type and temperatures.
>
> But the driver would add these default domains only if booted /loaded with
> missing DT device entry, right?

Yes Eduardo, but with default trip values not the absolute which is 
added with this patch series.

>
