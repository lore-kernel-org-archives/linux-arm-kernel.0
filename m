From: davidb@codeaurora.org (David Brown)
Date: Tue, 04 Jan 2011 11:00:05 -0800
Subject: [PATCH 1/4] ARM: runtime patching of __virt_to_phys() and
	__phys_to_virt()
In-Reply-To: <alpine.LFD.2.00.1101041330450.22191@xanadu.home> (Nicolas
	Pitre's message of "Tue, 04 Jan 2011 13:33:05 -0500 (EST)")
References: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
	<1294129208-15201-2-git-send-email-nico@fluxnic.net>
	<20110104084517.GA9791@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101040926100.22191@xanadu.home>
	<20110104165347.GA24935@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101041225070.22191@xanadu.home>
	<20110104180620.GC24935@n2100.arm.linux.org.uk>
	<8yahbdoh6fs.fsf@huya.qualcomm.com>
	<alpine.LFD.2.00.1101041330450.22191@xanadu.home>
Message-ID: <8ya39p8h4ui.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 04 2011, Nicolas Pitre wrote:

> On Tue, 4 Jan 2011, David Brown wrote:
>
>> Any idea how much it would hurt other targets to have the
>> __virt_to_phys() and __phys_to_virt() have a 16-bit fixup, even if only
>> the upper 8 bits are used?
>
> Probably not that much.  But let's make it work satisfactorily for the 
> general case first, and then we might consider and test variations that 
> could accommodate msm.

Sounds like a good plan.  We've got quite a few other things to clean up
before we can build for more than one arch anyway.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
