From: davidb@codeaurora.org (David Brown)
Date: Fri, 21 Jan 2011 14:47:05 -0800
Subject: [PATCH] ARM: msm: gpio-v2 irq_data conversion.
In-Reply-To: <20110121111110.GM13235@n2100.arm.linux.org.uk> (Russell King's
	message of "Fri, 21 Jan 2011 11:11:10 +0000")
References: <20110121110219.GD23596@mail.wantstofly.org>
	<20110121111110.GM13235@n2100.arm.linux.org.uk>
Message-ID: <8yak4hxoowm.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21 2011, Russell King - ARM Linux wrote:

> On Fri, Jan 21, 2011 at 12:02:19PM +0100, Lennert Buytenhek wrote:
>> Convert gpio-v2.c to the new irq_data methods.  This was overlooked
>> in the first pass as there is currently no defconfig in the tree that
>> builds this file.
>> 
>> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
>
> Rather than merging this into the MSM git tree, please let me have your
> acks so that it can be packaged up with the addition of adding
> 	select GENERIC_HARDIRQS_NO_DEPRECATED
> to the ARM architecture (otherwise MSM will break.)

Acked-by: David Brown <davidb@codeaurora.org>

I'm also working on getting some defconfigs for these targets into
linux-next.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
