From: joe@perches.com (Joe Perches)
Date: Sat, 26 Sep 2009 12:53:52 -0700
Subject: [PATCH] MAINTAINERS: ARM/Palm file patterns
In-Reply-To: <200909262114.08994.marek.vasut@gmail.com>
References: <1253990824.7128.25.camel@Joe-Laptop.home>
	<200909262114.08994.marek.vasut@gmail.com>
Message-ID: <1253994832.7128.44.camel@Joe-Laptop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2009-09-26 at 21:14 +0200, Marek Vasut wrote: 
> This might cause trouble, we're working on renaming treo680 (as below) to 
> palmtreo so palm* wont do ... you'll possibly have to list them or something. 
> Otherwise ok.

Another way to do this is:

F: arch/arm/mach-pxa/include/mach/palm(asoc|tx|t5|ld|te2|tc).h
F: arch/arm/mach-pxa/palm(tx|t5|ld|te2|tc).c
