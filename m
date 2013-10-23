From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 23 Oct 2013 19:45:00 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131023172955.GA17145@obsidianresearch.com>
References: <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
Message-ID: <20131023174458.GC5208@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 11:29:55AM -0600, Jason Gunthorpe wrote:
> 
> As far as I can see, all stable DTB gets you is the ability to flash
> the DTB into the firmware and never change it. Who does that actually
> help?

Once I design my board, and it goes into production, the hardware is
fixed. It doesn't change, and neither should the description of the
hardware, also known as the DTB. If I have to research all of the ways
that the bindings changed in order to upgrade my kernel, then I am
better off with the old, static, platform data. At least there the
compiler would complain if fields are removed or renamed. 

I understand that having the bindings in flux makes life easier for
kernel developers, as it frees them from the burden of having to think
about the consequences of their hasty decisions. But those people are
not the only users. There is a much larger body of users than that.

Thanks,
Richard
