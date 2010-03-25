From: dan.j.williams@intel.com (Dan Williams)
Date: Thu, 25 Mar 2010 08:13:35 -0700
Subject: [PATCH v2] PL330: Add PL330 DMA controller driver
In-Reply-To: <1b68c6791003250517y4e2789baoe147e5982c363682@mail.gmail.com>
References: <4BAAD5BB.7050101@samsung.com>	
	<1b68c6791003242234h106d9530p12b5a046a906227e@mail.gmail.com>	
	<63386a3d1003250130w6f34854ag2ca163799e9b7bed@mail.gmail.com>
	<1b68c6791003250517y4e2789baoe147e5982c363682@mail.gmail.com>
Message-ID: <4BAB7D9F.4070807@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

jassi brar wrote:
>> Perhaps Joonyoung can simply port over the stuff
>> you need to this driver if you show your code.
> Having worked on Samsung SoCs(with PL330 DMAC) based products, I would be
> _very_ surprised if any user found this implementation useful.
> Let alone testing, this implementation can't even explain usability
> for fast peripherals
> with shallow FIFOs. I didn't give feedback for this patch because I am
> not sure if this
> is the right way to go at all.

This is the wrong attitude.  If it were not for a simple oversight 
Joonyoung's driver would already be upstream for the past two kernel 
releases.  So you need to work together to improve that driver to 
incorporate what you need.

It sounds like you just need to add an extension for the arch specific 
dma api.  At first glance this can mimic the approach taken by 
Nobuhiro-san with the shdma driver.

--
Dan
