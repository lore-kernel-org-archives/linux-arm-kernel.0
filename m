From: bcrl@kvack.org (Benjamin LaHaise)
Date: Fri, 12 Oct 2012 10:22:54 -0400
Subject: alignment faults in 3.6
In-Reply-To: <1350043692.21172.11815.camel@edumazet-glaptop>
References: <20121005082439.GF4625@n2100.arm.linux.org.uk>
 <AE90C24D6B3A694183C094C60CF0A2F6026B703E@saturn3.aculab.com>
 <yw1xtxu1nfsn.fsf@unicorn.mansr.com> <201210120811.43290.arnd@arndb.de>
 <20121012090321.GA21164@n2100.arm.linux.org.uk>
 <yw1xhaq0nefg.fsf@unicorn.mansr.com>
 <20121012110750.GE21164@n2100.arm.linux.org.uk>
 <yw1x8vbcndlb.fsf@unicorn.mansr.com>
 <20121012114443.GG21164@n2100.arm.linux.org.uk>
 <1350043692.21172.11815.camel@edumazet-glaptop>
Message-ID: <20121012142254.GG5453@kvack.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2012 at 02:08:12PM +0200, Eric Dumazet wrote:
> So yes, we built network stack with the prereq that IP headers are
> aligned, but unfortunately many developers use x86 which doesnt care, so
> its possible some bugs are added.

x86 does have an alignment check flag that can be set in the flags register.  
Somehow, I doubt anyone would be willing to walk through all the noise the 
faults would likely trigger.

		-ben
-- 
"Thought is the essence of where you are now."
