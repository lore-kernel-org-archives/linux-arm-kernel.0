From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 21 May 2013 15:31:00 +0300
Subject: dmatest regression in 3.10-rc1
In-Reply-To: <20130520095857.GI31359@mudshark.cambridge.arm.com>
References: <20130515152803.GL23869@mudshark.cambridge.arm.com>
 <20130516153553.GI11706@mudshark.cambridge.arm.com>
 <20130517123423.GR14863@intel.com>
 <20130517141857.GM23112@mudshark.cambridge.arm.com>
 <1369036354.29283.115.camel@smile>
 <20130520095857.GI31359@mudshark.cambridge.arm.com>
Message-ID: <1369139460.29283.147.camel@smile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-05-20 at 10:58 +0100, Will Deacon wrote: 
> Sure. They way I trigger it is to unload the module whilst the DMA is
> ongoing (I'm using a software model, so I can make the DMA nice and slow --
> I guess you could try using some large buffers).

Thank you for the script. It looks like I managed to reproduce it with
help of your script. I'm about to send the patch. I will appreciate to
collect a Tested-by tags in case it solves the issue.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
