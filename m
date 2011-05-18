From: jdzheng@broadcom.com (Jiandong Zheng)
Date: Wed, 18 May 2011 15:45:32 -0700
Subject: [PATCH] ARM: bcmring: Add clkdev table in init_early
In-Reply-To: <20110518223700.GC21384@n2100.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
	<E1QM1e8-0003ET-HK@rmk-PC.arm.linux.org.uk>
	<4DD2FF02.1020508@broadcom.com>
	<20110517232015.GC5913@n2100.arm.linux.org.uk>
	<4DD307E2.7010302@broadcom.com>
	<20110518154641.GK5913@n2100.arm.linux.org.uk>
	<4DD40965.9020202@broadcom.com>
	<20110518204242.GA21384@n2100.arm.linux.org.uk>
	<20110518223700.GC21384@n2100.arm.linux.org.uk>
Message-ID: <4DD44C0C.1090907@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/18/2011 3:37 PM, Russell King - ARM Linux wrote:
> On Wed, May 18, 2011 at 09:42:42PM +0100, Russell King - ARM Linux wrote:
>> On Wed, May 18, 2011 at 11:01:09AM -0700, Jiandong Zheng wrote:
>>> ARM: bcmring: Move adding clkdev to init_early to make sure clkevent
>>> based on sp804 is initialized properly.
>>
>> Great, can you submit this to the patch system please?  Thanks.
>
> Erm, actually this patch is against your previous patch (as is the one
> which you submitted to the patch system) so it won't apply as-is.  It
> needs to be one which wil apply directly to mainline in this case please.
>
Hi Russell,

And my previous patch is based on your set of patches to do common sp804 
clock source. How should I submit mine?

Since I haven't had much experience with submitting patch so far, please 
allow me to ask a question which may be asked many times: when should I 
use patch system?

For example, I sent a couple of unrelated patches last week and seems no 
one has problem with them since I don't see comments regarding them. 
Should I submit them again through patch system or they will picked up 
"automatically"?

Thanks,
JD
