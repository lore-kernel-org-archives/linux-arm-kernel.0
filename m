From: jm@lentin.co.uk (Jamie Lentin)
Date: Wed, 11 Apr 2012 14:32:34 +0100
Subject: [PATCH V3 1/5] ARM: kirkwood: Basic support for DNS-320 and
 DNS-325
In-Reply-To: <20120411004324.GB14790@titan.lakedaemon.net>
References: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
 <1332885255-8304-2-git-send-email-jm@lentin.co.uk>
 <20120406234955.840F73E1323@localhost>
 <alpine.DEB.2.00.1204091418400.23719@marmot.wormnet.eu>
 <20120411004324.GB14790@titan.lakedaemon.net>
Message-ID: <op.wclrwkqi4cuzmg@gonzo.lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Apr 2012 01:43:24 +0100, Jason Cooper <jason@lakedaemon.net>  
wrote:

>> In a future land where everything has been converted to devicetree, what
>> would be best? An option to "Build all kirkwood-based .dtb's", an option
>> to build all D-link .dtb's, Q-QNAP .dtb's, etc. or an option for each
>> board? I've not got any strong opinion, so will reformat the above to
>> whatever is considered best.
>
> Based on Grant's comment, I'll probably be working towards a
> MACH_GLOBALSCALE_DT option to catch dreamplug,sheevaplug,guruplug, etc.
> Perhaps this should be MACH_BUFFALO_DT?
>

Thinking about it, MACH_DNSKW_DT would probably be best. Anything more  
general, e.g. MACH_DLINK_DNS_DT, would also cover the orion-based  
DNS-313/323/343. Presumably there will always be differences between  
kirkwood and orion5x?

Did you mean D-Link, or is there some relationship between Buffalo and  
D-link I'm not aware of? I know Conceptronic sold a ~identical device to  
the DNS-323, but not aware of anything else. You never know who truly  
makes the devices nowadays anyway.

-- 
Jamie Lentin
