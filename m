From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 22 May 2014 16:17:38 +0200
Subject: [PATCH 0/4] ARM: mvebu: Minor fixes and improvements to
 coherency_ll.S
In-Reply-To: <1400762882-10116-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400762882-10116-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <537E0702.7000102@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 22/05/2014 14:47, Thomas Petazzoni wrote:
> Jason, Andrew, Gregory, Sebastian,
> 
> Here is a small set of patches making fixes and improvements to the
> coherency_ll.S code.
> 
> The first patch is really important and fixes big endian booting in
> -next. The regression was introduced by the cpuidle changes, which are
> currently in -next.
> 
> The other three patches are only improvements, mainly cosmetic, but I
> believe they clarify a few things that took me a bit of time to
> re-understand this morning.
> 
> The patches are based on top of mvebu/soc.
> 

for the whole series:

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory


> Thanks,
> 
> Thomas
> 
> Thomas Petazzoni (4):
>   ARM: mvebu: fix big endian booting after coherency code rework
>   ARM: mvebu: fix indentation of assembly instructions in coherency_ll.S
>   ARM: mvebu: improve comments in coherency_ll.S
>   ARM: mvebu: returns ll_get_cpuid() to ll_get_coherency_cpumask()
> 
>  arch/arm/mach-mvebu/coherency_ll.S | 77 ++++++++++++++++++++++++--------------
>  1 file changed, 49 insertions(+), 28 deletions(-)
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
