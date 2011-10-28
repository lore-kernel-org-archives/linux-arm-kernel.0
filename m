From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 28 Oct 2011 11:34:22 -0700
Subject: [RFC] Shrink sched_clock some more
In-Reply-To: <4E7C48E2.5040907@arm.com>
References: <20110922153611.GC8072@n2100.arm.linux.org.uk>
	<4E7C48E2.5040907@arm.com>
Message-ID: <4EAAF5AE.6090300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/11 01:52, Marc Zyngier wrote:
> On 22/09/11 16:36, Russell King - ARM Linux wrote:
>> ... by getting rid of the fixed-constant optimization, and moving the
>> update code into arch/arm/kernel/sched_clock.c.
>>
>> Platforms now only have to supply a function to read the sched_clock
>> register, and some basic information such as the number of significant
>> bits and the tick rate.
> This looks similar to a patch I posted a while ago:
> http://patchwork.ozlabs.org/patch/112318/
>
>

Can we get one of these two patches merged next merge window? I'd like
to add sched_clock support to MSM and building on top of this patch is
easier than the other way around.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
