From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Thu, 14 Apr 2016 16:19:19 -0700
Subject: [PATCH 0/2] ARM: keystone: Enable CPU hotplug
In-Reply-To: <20160414221522.GX19428@n2100.arm.linux.org.uk>
References: <1459794543-4822-1-git-send-email-j-keerthy@ti.com>
 <57031F5F.3020300@oracle.com> <20160405113325.GF19428@n2100.arm.linux.org.uk>
 <20160414221522.GX19428@n2100.arm.linux.org.uk>
Message-ID: <57102577.8020905@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/14/2016 3:15 PM, Russell King - ARM Linux wrote:
> On Tue, Apr 05, 2016 at 12:33:25PM +0100, Russell King - ARM Linux wrote:
>> Now... if we could get the damn CPU fan under control, I might be
>> able to stand leaving the board powered on for longer, instead of
>> reaching for the power plug at the earliest possibility!
>
> This evening, I've received a complaint about the noise of the fan,
> which can be heard throughout the house.
>
:-) Fan is noisy.

> PLEASE can we sort something out about this damned fan?  I know that
> there's a PWM control of it, so let's get it more under control.  If
> no one is interested in writing a driver for it, then please supply
> me with the information so that I can sort this out, and stop it
> being so annoying.
>
Am not sure if this fan is wired to PWM controller though.

> Like I've said above, right now the board doesn't stay on for very
> long, and it's actually a very big _demotivator_ to powering the
> board on.
>
> This board is also *never* going anywhere near my boot farm because
> it's just too damned noisy to be powered up during the night, even
> if we do get the fan more under control once the kernel is running.
>
> If that's not enough to get some help with this, I'll instead snip
> the fan wire and solder a resistor in series with the fan to slow
> the damned thing down to reduce the noise level.
>
You should do that. I have less hope of other options.


Regards,
Santosh
