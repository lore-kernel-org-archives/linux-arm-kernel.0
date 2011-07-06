From: tim.bird@am.sony.com (Tim Bird)
Date: Wed, 6 Jul 2011 14:45:43 -0700
Subject: [PATCH] ARM: poison initmem when it is freed
In-Reply-To: <20110706210106.GX8286@n2100.arm.linux.org.uk>
References: <20110705184254.GH8286@n2100.arm.linux.org.uk>	<alpine.LFD.2.00.1107051509490.14596@xanadu.home>	<20110705192656.GJ8286@n2100.arm.linux.org.uk>	<alpine.LFD.2.00.1107051540550.14596@xanadu.home>	<4E139F8F.7060809@codeaurora.org>	<20110706203427
Message-ID: <4E14D787.4060003@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2011 02:01 PM, Russell King - ARM Linux wrote:
> On Wed, Jul 06, 2011 at 01:55:54PM -0700, Stephen Boyd wrote:
>> Should it include the initrd too? At least x86 poisons that memory but I
>> don't know who would be using that incorrectly.
> 
> It could do - I don't see any harm in not doing so.  The only issue
> is that people may want to disable this stuff if they're after
> squeezing every last ms out of the boot time.

I'd appreciate that.  I think the ability to poison is nice.
But if it takes any time at all it would be nice to be
able to disable it to avoid an increase in boot time.
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Workgroup of the Linux Foundation
Senior Staff Engineer, Sony Network Entertainment
=============================
