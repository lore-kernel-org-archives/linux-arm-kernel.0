From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 23 Mar 2012 15:26:42 +0530
Subject: [PATCH] SPEAr: Use CLKDEV_INIT for defining clk_lookups
In-Reply-To: <201203230848.52010.arnd@arndb.de>
References: <57103011de8747743f95eb41c8dc30c632d097a8.1332490263.git.viresh.kumar@st.com>
 <201203230848.52010.arnd@arndb.de>
Message-ID: <4F6C48DA.9080005@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/23/2012 2:18 PM, Arnd Bergmann wrote:
> Since we're in the middle of the merge window now, I would
> prefer not to pull any cosmetic changes or new features but
> instead just take the bug fix. Once -rc1 is done, we will
> start taking patches for v3.5.
> 

Ok.

> If the second patch is actually required and nit just cosmetic,
> please provide a description why that is so.

It is just an cosmetic one. I posted it, so stefan can work over
it and i don't have to rework on it again. What's the preferred
way of handling such stuff during merge window?

> Finally, the branch you mentioned does not seem to be there
> on the server.

I am so sorry. Actually we have two interfaces to stlinux, one
is ST internal and other is external. I have pushed the branch
at the time i posted it, but stlinux site takes a bit to get
everything synched (i came to know this today only :( ).

> I recommend using 'git request-pull', which will actually check
> that the branch you refer to can be pulled and holds the right
> contents.

Sure.

--
Viresh
