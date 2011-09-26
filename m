From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 26 Sep 2011 14:35:06 +0200
Subject: [PATCH 07/11] OMAP2+: board-generic: Add DT support to generic
	board
In-Reply-To: <20110923230845.GD6324@atomide.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
	<1316809399-19579-8-git-send-email-b-cousson@ti.com>
	<20110923230845.GD6324@atomide.com>
Message-ID: <4E80717A.3040502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/24/2011 1:08 AM, Tony Lindgren wrote:
> * Benoit Cousson<b-cousson@ti.com>  [110923 12:50]:
>> Re-cycle the original board-generic file to support Device Tree
>> for every OMAP2+ variants.
>> Note: Since it is a completely new content in the existing file
>> I removed the original copyright.
>
> I'd suggest just keeping it, maybe just update the comments
> accordingly?

Do you mean keeping it and adding the comment? Or removing it and adding 
the comment?

> That's because Copyrights in general just don't "disappear".

OK, maybe, but I thought it is weird to keep an old copyright just 
because we re-use an already existing file since the content is different.

> And the meaning of the board-generic is still the same as originally,
> that is do the booting based on board-specific data passed from
> the bootloader like the comments say:
>
>> - * Code for generic OMAP2 board. Should work on many OMAP2 systems where
>> - * the bootloader passes the board-specific data to the kernel.
>> - * Do not put any board specific code to this file; create a new machine
>> - * type if you need custom low-level initializations.
>> + * Support for generic OMAP2+ device tree boards.

Regards,
Benoit
