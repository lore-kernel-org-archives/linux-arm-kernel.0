From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Mar 2012 11:39:23 +0000
Subject: [PATCH] SPEAr: Use CLKDEV_INIT for defining clk_lookups
In-Reply-To: <4F6C48DA.9080005@st.com>
References: <57103011de8747743f95eb41c8dc30c632d097a8.1332490263.git.viresh.kumar@st.com>
 <201203230848.52010.arnd@arndb.de> <4F6C48DA.9080005@st.com>
Message-ID: <201203231139.23574.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 March 2012, Viresh Kumar wrote:
> > If the second patch is actually required and nit just cosmetic,
> > please provide a description why that is so.
> 
> It is just an cosmetic one. I posted it, so stefan can work over
> it and i don't have to rework on it again. What's the preferred
> way of handling such stuff during merge window?

Best just send bug fixes for inclusion, but no other patches. You
can of course post any patches for review and discuss them on
the list, but I won't apply stuff for v3.5 before Linus has taken
the base v3.4 stuff.

	Arnd
