From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 24 Oct 2013 09:32:37 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <1382570963.6315.48.camel@deadeye.wl.decadent.org.uk>
References: <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
 <20131023180108.GA23728@roeck-us.net>
 <20131023182502.GC32563@obsidianresearch.com>
 <20131023183041.GH5208@netboy>
 <1382570963.6315.48.camel@deadeye.wl.decadent.org.uk>
Message-ID: <20131024073236.GA4690@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 12:29:23AM +0100, Ben Hutchings wrote:
> 
> It starts by looking up the machine ID (in procfs, but may be overridden
> because some board vendors don't set it correctly).  If the machine is
> supported using FDT then there is an associated DTB file which will have
> been installed with the kernel.  The script copies/appends this to the
> appropriate place for the boot loader.

And if the ID is not recognized, then what?

Thanks,
Richard
