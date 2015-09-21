From: m-karicheri2@ti.com (Murali Karicheri)
Date: Mon, 21 Sep 2015 11:44:54 -0400
Subject: possible reason: unannotated irqs-off
In-Reply-To: <20150918170226.GK21084@n2100.arm.linux.org.uk>
References: <55FC3587.7010601@ti.com>
 <20150918170226.GK21084@n2100.arm.linux.org.uk>
Message-ID: <560025F6.6030700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 09/18/2015 01:02 PM, Russell King - ARM Linux wrote:
> On Fri, Sep 18, 2015 at 12:02:15PM -0400, Murali Karicheri wrote:
>> While chasing a fix for a deadlock in netcp driver with debug options
>> enabled, i bumped on another warning shown below.. Looks like I need to
>> enable CONFIG_IRQSOFF_TRACER as well to get rid of this. Have anyone seen
>> this? My google search showed me some connection with this option and I
>> enabled it as well and I don't see the warning anymore. Any idea if this is
>> a false alarm or a real bug? Looks like I need to enable
>> CONFIG_IRQSOFF_TRACER as well. If so, I can send a patch. Either way let me
>> know.
>
> Do you have this commit applied?

No. We are using v4.1.x.

>
> commit 3302caddf10ad50710dbb7a94ccbdb3ad5bf1412
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Thu Aug 20 16:13:37 2015 +0100
>
>      ARM: entry: efficiency cleanups
>

I have cherry-picked this one, but ran into some conflicts which I have 
fixed. Will try and let you know.

Thanks
-- 
Murali Karicheri
Linux Kernel, Keystone
