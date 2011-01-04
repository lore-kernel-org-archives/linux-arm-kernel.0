From: davidb@codeaurora.org (David Brown)
Date: Tue, 04 Jan 2011 15:14:00 -0800
Subject: [RFC 5/5] ARM: P2V: extend to 16-bit translation offsets
In-Reply-To: <E1PaDPu-00023p-QG@rmk-PC.arm.linux.org.uk> (Russell King's
	message of "Tue, 04 Jan 2011 20:23:38 +0000")
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDPu-00023p-QG@rmk-PC.arm.linux.org.uk>
Message-ID: <8yalj30feiv.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 04 2011, Russell King - ARM Linux wrote:

> MSM's memory is aligned to 2MB, which is more than we can do with our
> existing method as we're limited to the upper 8 bits.  Extend this by
> using two instructions to 16 bits, automatically selected when MSM is
> enabled.

I've verified that the these 5 patches boot on an MSM QSD 8x50, both
with and without ARM_PATCH_PHYS_VIRT enabled.  I haven't tried building
with a different offset than it is running at, yet.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
