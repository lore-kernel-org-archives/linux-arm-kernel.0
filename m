From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 25 Mar 2013 14:41:00 +0530
Subject: [PATCH] ARM: hw_breakpoint: Enable debug powerdown only if system
 supports 'has_ossr'
In-Reply-To: <20130319102803.GB22452@mudshark.cambridge.arm.com>
References: <1363157553-21085-1-git-send-email-lokeshvutla@ti.com>
 <51406BA7.8010306@arm.com> <51407120.7030709@ti.com>
 <51417E58.5050501@ti.com> <20130315050014.GA15706@tiny-lites>
 <5146B972.1010002@ti.com> <20130318150724.GC28585@mudshark.cambridge.arm.com>
 <514736D4.4070906@ti.com> <20130318170649.GA29585@mudshark.cambridge.arm.com>
 <5148082A.3060503@ti.com> <20130319102803.GB22452@mudshark.cambridge.arm.com>
Message-ID: <515014A4.5020504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On Tuesday 19 March 2013 03:58 PM, Will Deacon wrote:
> On Tue, Mar 19, 2013 at 06:39:38AM +0000, Santosh Shilimkar wrote:
>> On Monday 18 March 2013 10:36 PM, Will Deacon wrote:

[..]

>>> Well, we could just add the warn_once prints but that doesn't stop debug
>>> from breaking after the first pm/suspend/hotplug operation.
>>>
>> Probably we should drop the $subject patch approach and use warn_once
>> at least for current rc. Ofcourse it doesn't help to get working
>> hw_breakpoint support. Patch end of the email with warn_once.
> 
> Yeah, I'll merge that, but it's a real shame that this breaks hardware debug
> on one of the few platforms where it was reported to work.
> 
Are you going to send the patch for 3.9-rcx ? As I said before without the
patch OMAP4 CPUILDE is unusable because of that debug noise and hence it
will be good to get that patch in

Regards,
Santosh
