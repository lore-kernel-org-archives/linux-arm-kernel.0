From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Mar 2011 13:52:31 +0000
Subject: [PATCH V6 00/11] SPEAr3xx & SPEAr6xx: Single Image solution
	and padmux updates
In-Reply-To: <4D7E05E5.9050602@st.com>
References: <cover.1298977709.git.viresh.kumar@st.com>
	<4D7E05E5.9050602@st.com>
Message-ID: <20110321135231.GA4340@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2011 at 05:41:17PM +0530, viresh kumar wrote:
> On 03/01/2011 04:56 PM, Viresh KUMAR wrote:
> > This patchset contains following updates for SPEAr3xx & SPEAr6xx:
> > - Pad multiplexing updates
> > - Single Image solution
> > 
> > Note: These patches were earlier sent as part of a larger patchset:
> > "Updating SPEAr Support"
> > 
> > Now it is divided into smaller patchsets. In order to apply these patches
> > cleanly following order of patchsets must be maintained.
> > - SPEAr3xx & SPEAr6xx Fixes
> > - SPEAr3xx & SPEAr6xx: Single Image solution and padmux updates
> > - Adding SPEAr13xx support
> > - Adding devices support for all spear machines
> > - Clock Framework & CPU Freq Updates
> > 
> > Ryan Mallon (5):
> >   ST SPEAr3xx: Make local shirq structures static
> >   ST SPEAR3xx: Rename register/irq defines to remove naming conflicts
> >   ST SPEAr3xx: Rework pmx_dev code to remove conflicts
> >   ST SPEAr3xx: Rework KConfig to allow all boards to be compiled in
> >   ST SPEAr3xx: Replace defconfigs with single unified defconfig
> > 
> > Vipin Kumar (1):
> >   ST SPEAr: Pad multiplexing handling modified
> > 
> > Viresh Kumar (5):
> >   ST SPEAr clock: Define common clk_init routine in plat/clock.c
> >   ST SPEAr Clock: Updating for single image solution
> >   ST SPEAr3xx: Appending spear3** with global device structures
> >   ST SPEAr6xx: Rework Kconfig for single image solution
> >   ST SPEAR6xx: renaming spear600_defconfig as spear6xx_defconfig
> 
> Russell,
> 
> Should i push this patch-set to tracker?

I won't be incorporating it until after the merge window.
