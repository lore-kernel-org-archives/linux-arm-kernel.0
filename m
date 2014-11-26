From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 26 Nov 2014 14:40:55 +0000
Subject: [PATCH 2/2] MAINTAINERS: ARM Versatile Express platform
In-Reply-To: <2667096.evZZoH9ryD@wuerfel>
References: <1416939455-1814-1-git-send-email-pawel.moll@arm.com>
 <1416967146.8358.19.camel@perches.com> <1417003449.3972.1.camel@arm.com>
 <2667096.evZZoH9ryD@wuerfel>
Message-ID: <1417012855.3972.3.camel@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-11-26 at 12:17 +0000, Arnd Bergmann wrote:
> On Wednesday 26 November 2014 12:04:09 Pawel Moll wrote:
> > 
> > Right, of course. Whole directory.
> > 
> > > F:    */*/vexpress*
> > 
> > Cool, didn't think about multiple wildcards. 
> 
> Actually, I think you could even do this as
> 
> N:	vexpress
> 
> which would be even shorter and match most of the other entries too.

If you think it's safe, fine with me. It would reduce this section to:

N:	vexpress
F:	drivers/clocksource/versatile.c

I'll spin the patch again.

Pawel
