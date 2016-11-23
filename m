From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Nov 2016 07:55:03 -0800
Subject: [RFC PATCH 11/11] ARM: Allow ARCH_MULTIPLATFORM to be selected
 for NOMMU
In-Reply-To: <583478FB.4020008@arm.com>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-12-git-send-email-vladimir.murzin@arm.com>
 <16587553.f9R1mxJih5@wuerfel> <583478FB.4020008@arm.com>
Message-ID: <20161123155503.GE4082@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vladimir Murzin <vladimir.murzin@arm.com> [161122 08:57]:
> On 22/11/16 10:17, Arnd Bergmann wrote:
> > Another question is what architecture levels and what platforms
> > we want to support without MMU. The only ARMv4/v5 platform we
> > still have that can actually use NOMMU cores is Integrator
> > with its ARM7TDMI, ARM920T and ARM966E core tiles (and possibly
> > others I couldn't immediately find). Do we actually care about
> > them any more now that all the NOMMU world is ARMv7-M? Are
> > there any benefits in running an ARM920T or ARM926E core
> > with MMU disabled, and does this work with your patches?
> > 
> 
> I don't have such hardware, so I can't acctually test it - it is why "there is
> no guaranty" :( OTOH, if sombody has these platforms these pathces is a good
> start to try NOMMU.

I believe the reason to run them without MMU might be still
valid if we ever get mainline Linux kernel working on some
3G/LTE modems for latency reasons. Not that I know of any
use cases, but if we have it working we might as well keep
it working.

Regards,

Tony
