From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 6 Sep 2010 17:22:30 +0530
Subject: [PATCH 07/74] ST SPEAr13XX: Added compilation support in arch/arm/
In-Reply-To: <20100902162744.GC28968@game.jcrosoft.org>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<b2e8b6b95ceff7d90032be8cd614787519b5c57c.1283161023.git.viresh.kumar@st.com>
	<20100902162744.GC28968@game.jcrosoft.org>
Message-ID: <4C84D5FE.2000507@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/2/2010 9:57 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 16:08 Mon 30 Aug     , Viresh KUMAR wrote:
>> > From: Shiraz Hashim <shiraz.hashim@st.com>
> missing patch descriptin

Sorry!!

>> > 
>> > Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
>> > Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>> > ---
>> >  arch/arm/Kconfig  |   12 ++++++++----
>> >  arch/arm/Makefile |    1 +
>> >  2 files changed, 9 insertions(+), 4 deletions(-)
>> > 
>> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> > index 9295110..950c045 100644
>> > --- a/arch/arm/Kconfig
>> > +++ b/arch/arm/Kconfig
>> > @@ -1144,11 +1144,13 @@ config SMP
>> >  	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
>> >  	depends on EXPERIMENTAL && (REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP ||\
>> >  		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 ||\
>> > -		 ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4)
>> > +		 ARCH_S5PV310 || ARCH_SPEAR13XX || ARCH_TEGRA || ARCH_U8500 ||\
>> > +		 ARCH_VEXPRESS_CA9X4)
> can we get rid of such long list by introducing a HAVE somthing
> etc....

Yes. We can select SMP from different Architecture config's.
Will do this in a separate patch.

viresh.
