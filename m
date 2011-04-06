From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 06 Apr 2011 23:43:33 +0200
Subject: [PATCH 2/2] ARM: Remove machine type dockstar (use sheevaplug
	instead)
In-Reply-To: <alpine.LFD.2.00.1104061700440.28032@xanadu.home>
References: <1302122121-3652-1-git-send-email-holler@ahsoftware.de>
	<1302122121-3652-3-git-send-email-holler@ahsoftware.de>
	<alpine.LFD.2.00.1104061700440.28032@xanadu.home>
Message-ID: <4D9CDE85.4050007@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.04.2011 23:02, Nicolas Pitre wrote:
> On Wed, 6 Apr 2011, Alexander Holler wrote:
>
>> There is no need to have a different machine type for Seagate DockStars.
>> Remove it.
>>
>> Be aware, this patch requires a change in the bootloader to feed the
>> same machine type to the kernel as used for Marvell SheevaPlugs.
>
> This is therefore not a good idea to do this.

The original bootloader isn't affected at all, only already modified 
ones which are using the machine type dockstar. And I don't think this 
are that many because that machine type was only supported for one or 
two revisions of U-Boot.

Regards,

Alexander Holler
