From: davidb@codeaurora.org (David Brown)
Date: Fri, 04 Mar 2011 09:11:52 -0800
Subject: [RFC PATCH 13/20] ARM: msm: dynamically register local timer
	setup function
In-Reply-To: <1299258355.10633.68.camel@e102391-lin.cambridge.arm.com> (Marc
	Zyngier's message of "Fri, 04 Mar 2011 17:05:55 +0000")
References: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
	<1299084806-16546-14-git-send-email-marc.zyngier@arm.com>
	<8ya62rzlsol.fsf@huya.qualcomm.com>
	<1299236990.10633.62.camel@e102391-lin.cambridge.arm.com>
	<8yawrkekece.fsf@huya.qualcomm.com>
	<1299258355.10633.68.camel@e102391-lin.cambridge.arm.com>
Message-ID: <8yak4gekdyf.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04 2011, Marc Zyngier wrote:

> On Fri, 2011-03-04 at 09:03 -0800, David Brown wrote:
>> On Fri, Mar 04 2011, Marc Zyngier wrote:
>> 
>> > On Thu, 2011-03-03 at 14:56 -0800, David Brown wrote:
>> 
>> >> Basic sanity test seems to be working at least on UMP.  Currently
>> >> testing SMP.
>> >
>> > Thanks for that. Please let me know how SMP goes.
>> 
>> Appears to work fine.
>
> Brilliant. May I add a Tested-By: tag on the fixed version?

Sure:

Tested-by: David Brown <davidb@codeaurora.org>

at least on this patch.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
