From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 23 Oct 2013 20:51:17 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <1382553982.31058.10.camel@sakura.staff.proxad.net>
References: <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
 <20131023174458.GC5208@netboy>
 <1382553982.31058.10.camel@sakura.staff.proxad.net>
Message-ID: <20131023185116.GJ5208@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 08:46:22PM +0200, Maxime Bizon wrote:
> 
> the first iteration of your DTB would be incomplete, the bindings to
> describe that hardware block would not exist inside it.
> 
> real life example with Marvell Kirkwood, hw crypto support was added 1
> year after initial SOC support.
> 
> I'm happy I can use it now on existing boards by "just" upgrading the
> kernel.

I have no problem with new kernel features unlocked by new DT
bindings.

I *do* have a problem with new kernels breaking existing DT bindings.

Thanks,
Richard
