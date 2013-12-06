From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 6 Dec 2013 17:19:41 +0100
Subject: Moschip MCS8142 SoC
In-Reply-To: <OF1C2A9619.4A882547-ON86257C39.0011D73C-86257C39.00137859@rockwellcollins.com>
References: <OF433D4F00.CB35F8E7-ON86257C37.004F3E8D@rockwellcollins.com>
 <201312060331.31958.arnd@arndb.de>
 <OF1C2A9619.4A882547-ON86257C39.0011D73C-86257C39.00137859@rockwellcollins.com>
Message-ID: <201312061719.41731.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 December 2013, mlweber1 at rockwellcollins.com wrote:
> > Jonas Jensen is working on support for the "moxart" platform, which uses
> > the same fa526 core and which is similar in other regards, so I'd 
> recommend
> > looking at his code as examples for how to do this the right way.
> 
> Thanks, I'll take a look at (http://lwn.net/Articles/554101/).  I guess in 
> 
> some ways this would at least get my chip booting past the initial arch 
> related asm stuff and if my DT is setup with the right serial port, the 
> console should at least show some output until it dies.

A good first step is normally to get debug_ll running first. This requires
the least amount of work and gives you some form of debug output at the
first instruction in the kernel.

	Arnd
