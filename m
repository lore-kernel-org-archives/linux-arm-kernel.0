From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 2 May 2012 13:41:42 +0000
Subject: [PATCH 00/15] arch/arm/mach-* late_initcall cleanup
In-Reply-To: <20120502133757.GB2194@S2101-09.ap.freescale.net>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
 <201205021245.02831.arnd@arndb.de>
 <20120502133757.GB2194@S2101-09.ap.freescale.net>
Message-ID: <201205021341.43041.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 May 2012, Shawn Guo wrote:
> > On a related note, do you plan to do the same thing for subsys_initcall?
> > 
> I was asked by Russell to clean up late_initcall when I was trying to
> propose some something to help imx cpuidle drivers, so I did not really
> plan to do the same thing for subsys_initcall.  However, since you are
> asking, I think I can do it.  But I would defer it a little bit until
> we have device tree kill some amount of board files.

Ok, fair enough. I don't see a reason to rush the subsys_initcall conversion,
it just felt odd to do it for late_initcall first when there are so many more
instances of subsys_initcall in arch/arm. We can also ask the next person
who wants to add a subsys_initcall to do that work, so you don't have to
do it all by yourself ;-)

	Arnd
