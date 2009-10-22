From: albin.tonnerre@free-electrons.com (Albin Tonnerre)
Date: Thu, 22 Oct 2009 17:47:54 +0200
Subject: [PATCH v2] Add cpuidle support for at91
In-Reply-To: <4AC2168B.60903@atmel.com>
References: <1247680190-19674-1-git-send-email-albin.tonnerre@free-electrons.com>
	<200908111200.58866.marc.pignat@hevs.ch>
	<20090812165700.GC4051@pc-ras4041.res.insa>
	<200908130858.47487.marc.pignat@hevs.ch>
	<20090813193241.GA5985@pc-ras4041.res.insa>
	<20090909151417.GA4014@pc-ras4041.res.insa>
	<4AC2168B.60903@atmel.com>
Message-ID: <20091022154754.GB9854@pc-ran3241.res.insa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Sending it to the right list this time, sorry for the noise]

On Tue, 29 Sep 2009 16:15 +0200, Nicolas Ferre wrote :
> > On Thu, 13 Aug 2009 21:32 +0200, Albin Tonnerre wrote :
> >> This patch adds the support for cpuidle on AT91 SoCs, taken from the
> >> cpuidle support in mach-kirkwood.
> >> cpuidle needs sdram_selfrefresh_enable and _disable, so move their
> >> definition to a separate header file instead of duplicating the code
> >> already used in pm.c.
> >>
> >> Signed-off-by: Albin Tonnerre <albin.tonnerre@free-electrons.com>
> 
> [nicolas.ferre at atmel.com: tested on at91sam9263ek]
> Tested-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Andrew: what's your opinion on this? If it's OK, I'd really like to see it
pushed forward.

Regards,
-- 
Albin Tonnerre, Free Electrons
Kernel, drivers and embedded Linux development,
consulting, training and support.
http://free-electrons.com
