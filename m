From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 15 Feb 2012 14:14:53 +0100
Subject: [PATCH 1/4] ARM: OMAP2+: board-generic: Remove un-needed
 .atag_offset for DT_MACHINE
In-Reply-To: <20120214195249.GS1426@atomide.com>
References: <1329150625-8604-2-git-send-email-b-cousson@ti.com>
 <20120214195249.GS1426@atomide.com>
Message-ID: <4F3BAFCD.2000508@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/14/2012 8:52 PM, Tony Lindgren wrote:
> * Benoit Cousson<b-cousson@ti.com>  [120213 07:59]:
>> Some .atag_offset entries were wrongly added during a merge conflict
>> resolution in 3.3.
>> Remove them all, since DT boot does not use that attribute anymore.
>>
>> Replace as well the #if... by #ifdef for consistency.
>
> How about let's also remove the 0x from the serial at 0x.. in the .dts
> files in this clean-up patch?

In the same patch?

I'm fine with fixing that as well, but since this is not in the same 
file / directory, I'd rather do a different patch.

I'll do the fix anyway, it is up to you for the proper location.

Thanks,
Benoit
