From: davidb@codeaurora.org (David Brown)
Date: Wed, 19 Jan 2011 11:52:02 -0800
Subject: [PATCH 2/2] serial: msm: Add support for UARTDM cores
In-Reply-To: <20110119173739.GE3341@pulham.picochip.com> (Jamie Iles's message
	of "Wed, 19 Jan 2011 17:37:39 +0000")
References: <1295407585-18386-1-git-send-email-stepanm@codeaurora.org>
	<20110119082534.GA9569@gallagher> <8yaaaiwsstw.fsf@huya.qualcomm.com>
	<20110119173739.GE3341@pulham.picochip.com>
Message-ID: <8ya7he0r7rx.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19 2011, Jamie Iles wrote:

> On Wed, Jan 19, 2011 at 09:31:55AM -0800, David Brown wrote:
>> I'm not sure what would be a better name for the flag, though.  The
>> block is called UARTDM.
>
> Ok, it was mainly out of curiosity.  I guess it could be 'use_dma' or 
> perhaps a comment to explain what DM is but my curiosity is now 
> satisfied ;-)

I think use_dma would probably be even more confusing, since it isn't
using dma.

It's a flag indicating if the device has the capability of doing dma.
It's really a block version indicator, except that the blocks weren't
given different versions, but instead given a name based on the DMA.

I wonder if is_dma_capable would be better.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
