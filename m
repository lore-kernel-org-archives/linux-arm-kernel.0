From: grfstrm@users.sourceforge.net (=?ISO-8859-1?Q?Anders_Grafstr=F6m?=)
Date: Mon, 15 Mar 2010 16:20:00 +0100
Subject: [PATCH 03/11] Thumb-2: Implementation of the unified start-up
	and	exceptions code
In-Reply-To: <alpine.LFD.2.00.1003121640280.31128@xanadu.home>
References: <20090602130549.12732.15147.stgit@pc1117.cambridge.arm.com>	<4B9A7A3C.9000304@users.sourceforge.net>	<20100312211614.GC1146@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1003121640280.31128@xanadu.home>
Message-ID: <4B9E5020.2020706@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote:
> On Fri, 12 Mar 2010, Russell King - ARM Linux wrote:
> 
>> So yes, your patch is absolutely required - all ARMv5 and below are
>> facing a hazard as the kernel stands.  It might explain some of the
>> weird behaviours people have been reporting as well.
>>
>> Please cleanup the description and submit to the patch system.
> 
> And please add a small comment along side the otherwise seemingly 
> useless nop.

Done.

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5991/1
