From: joe@perches.com (Joe Perches)
Date: Sat, 26 Sep 2009 12:30:03 -0700
Subject: [PATCH] MAINTAINERS: ARM/Palm file patterns
In-Reply-To: <200909262114.08994.marek.vasut@gmail.com>
References: <1253990824.7128.25.camel@Joe-Laptop.home>
	<200909262114.08994.marek.vasut@gmail.com>
Message-ID: <1253993403.7128.38.camel@Joe-Laptop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2009-09-26 at 21:14 +0200, Marek Vasut wrote:
> Dne So 26. z??? 2009 20:47:04 Joe Perches napsal(a):
> > For the section you maintain, are these file patterns correct?
> > +F:	arch/arm/mach-pxa/include/mach/palm*
> > +F:	arch/arm/mach-pxa/palm*
> 
> This might cause trouble, we're working on renaming treo680 (as below) to 
> palmtreo so palm* wont do ... you'll possibly have to list them or something. 
> Otherwise ok.

if/when you do, a specific list could be used
or maybe exclude patterns could be added

F:	arch/arm/mach-pxa/palmtx.c
F:	arch/arm/mach-pxa/palmt5.c
F:	arch/arm/mach-pxa/palmld.c
F:	arch/arm/mach-pxa/palmte2.c
F:	arch/arm/mach-pxa/palmtc.c

or

F:	arch/arm/mach-pxa/palm*
X:	arch/arm/mach-pxa/palmtreo*
X:	arch/arm/mach-pxa/palmz72*
