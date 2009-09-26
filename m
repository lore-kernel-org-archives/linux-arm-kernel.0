From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 26 Sep 2009 22:30:43 +0200
Subject: [PATCH] MAINTAINERS: ARM/Palm file patterns
In-Reply-To: <1253994832.7128.44.camel@Joe-Laptop.home>
References: <1253990824.7128.25.camel@Joe-Laptop.home>
	<200909262114.08994.marek.vasut@gmail.com>
	<1253994832.7128.44.camel@Joe-Laptop.home>
Message-ID: <200909262230.43385.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne So 26. z??? 2009 21:53:52 Joe Perches napsal(a):
> On Sat, 2009-09-26 at 21:14 +0200, Marek Vasut wrote:
> > This might cause trouble, we're working on renaming treo680 (as below) to
> > palmtreo so palm* wont do ... you'll possibly have to list them or
> > something. Otherwise ok.
> 
> Another way to do this is:
> 
> F: arch/arm/mach-pxa/include/mach/palm(asoc|tx|t5|ld|te2|tc).h
> F: arch/arm/mach-pxa/palm(tx|t5|ld|te2|tc).c
> 
palmasoc will hopefully go to hell soon anyway. Otherwise, I'm for the second 
method (listing the files, one per line), it's least confusing.

Cheers!
