From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 02 Apr 2012 11:20:01 +0200
Subject: Support for Iomega iConnect
In-Reply-To: <201203302330.49834.linux@baker-net.org.uk> (Adam Baker's message
 of "Fri, 30 Mar 2012 23:30:49 +0100")
References: <201203302330.49834.linux@baker-net.org.uk>
Message-ID: <87ty125w3i.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adam Baker <linux@baker-net.org.uk> writes:

> Hi,

Hi,

>
> Is anyone aware of any technical reason why support for the Iomega iConnect is 
> not included in the mainline kernel (e.g. there are significant changes 
> happening in the area of the Kirkwood CPUs that mean now isn't a good time to 
> include it). There are several versions floating around the internet but as far 
> as I can see the only mention of the iConnect on this list is Russell saying 
> he will remove it from mach types soon as there is no mainline support for it.
>
> Based upon work that Iomega posted to the open source code area on their web 
> site and code that was submitted to OpenWRT with a sign off line from Wojciech 
> Dubowik, I have patched support into the 3.2.11 kernel. If there is no 
> objection in principle to inclusion then I will rebase the patch and submit 
> it.

fwiw, I'm working on getting iconnect supported in mainline. I've written a
patch for it but it's not DT powered so I'm currently looking at
kirkwood DT stuff in order to convert it to DT. Once it'll be done, I'll
submit that to mainline.


Arnaud
