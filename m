From: davidb@codeaurora.org (David Brown)
Date: Thu, 17 Feb 2011 08:19:32 -0800
Subject: [RFC 2/5] ARM: P2V: avoid initializers and assembly using
	PHYS_OFFSET
In-Reply-To: <20110217141129.GG24627@n2100.arm.linux.org.uk> (Russell King's
	message of "Thu, 17 Feb 2011 14:11:29 +0000")
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOv-00023d-Gi@rmk-PC.arm.linux.org.uk>
	<20110217141129.GG24627@n2100.arm.linux.org.uk>
Message-ID: <8yak4gyvdkb.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 17 2011, Russell King - ARM Linux wrote:

> On Tue, Jan 04, 2011 at 08:22:37PM +0000, Russell King - ARM Linux wrote:
>> As PHYS_OFFSET will be becoming a variable, we can't have it used in
>> initializers nor assembly code.  Replace those in generic code with
>> a run-time initialization.  Replace those in platform code using the
>> individual platform specific PLAT_PHYS_OFFSET.
>
> I'm still missing acks for MSM, PXA and TCC8k stuff for this change.

Sorry, I did test it, but forgot an explicit Ack:

  Acked-by: David Brown <davidb@codeaurora.org>

David
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
