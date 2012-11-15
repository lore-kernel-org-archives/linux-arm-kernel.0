From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 15 Nov 2012 15:35:47 -0600
Subject: [PATCH] ARM: OMAP2+: Fix compiler warning for 32k timer
In-Reply-To: <20121115204526.GC12466@arwen.pp.htv.fi>
References: <1353008644-24745-1-git-send-email-jon-hunter@ti.com>
 <20121115204526.GC12466@arwen.pp.htv.fi>
Message-ID: <50A56033.6080908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/15/2012 02:45 PM, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Nov 15, 2012 at 01:44:04PM -0600, Jon Hunter wrote:
>> +static struct of_device_id omap_counter_match[] __initdata = {
> 
> not directly related to $SUBJECT, but shouldn't this be static const
> __initconst ?

Yes you are right. Looks like there are several other of_device_id
structs in arch/arm/mach-omap2 that could be updated to const too.

Cheers
Jon
