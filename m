From: tony@atomide.com (Tony Lindgren)
Date: Thu, 15 May 2014 11:32:48 -0700
Subject: RCU stall on panda
In-Reply-To: <5374C07C.1070400@linaro.org>
References: <53675C5F.10509@linaro.org>
 <20140505180617.GM8754@linux.vnet.ibm.com>
 <20140512212102.GF5668@atomide.com> <5371BD69.8010600@linaro.org>
 <20140513153220.GC16837@atomide.com> <53747E6D.60500@linaro.org>
 <53748371.5030704@linaro.org> <5374C07C.1070400@linaro.org>
Message-ID: <20140515183247.GF23659@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Alex Shi <alex.shi@linaro.org> [140515 06:27]:
> On 05/15/2014 05:05 PM, Daniel Lezcano wrote:
> >>>
> >>
> >> After enable this patch, system maybe hang in idle. :(
> > 
> > Hi Alex,
> > 
> > do you mean even with this revert applied, the board hangs in idle ?
> > 
> 
> yes.
> My board is panda ES. without this revert, it works.

Care to specify what linux version you are testing against?

Does it hang in idle always immediately on booting?

Or does the serial console first hang with sysrq still
working (ctrl-a h in minicom for help) with device
eventually locking up hard?

Regards,

Tony
