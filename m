From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Mar 2012 08:48:51 +0000
Subject: [PATCH] SPEAr: Use CLKDEV_INIT for defining clk_lookups
In-Reply-To: <57103011de8747743f95eb41c8dc30c632d097a8.1332490263.git.viresh.kumar@st.com>
References: <57103011de8747743f95eb41c8dc30c632d097a8.1332490263.git.viresh.kumar@st.com>
Message-ID: <201203230848.52010.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 March 2012, Viresh Kumar wrote:
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
> Arnd,
> 
> I have applied this patch after applying Stefan's patch:
> "ARM: SPEAr600: Change FSMC and SMI clock names"
> 
> I have applied both these patches in my following branch:
> spear-dt
> 

Hi Viresh,

Since we're in the middle of the merge window now, I would
prefer not to pull any cosmetic changes or new features but
instead just take the bug fix. Once -rc1 is done, we will
start taking patches for v3.5.

If the second patch is actually required and nit just cosmetic,
please provide a description why that is so.

Finally, the branch you mentioned does not seem to be there
on the server.

I recommend using 'git request-pull', which will actually check
that the branch you refer to can be pulled and holds the right
contents.

	Arnd
