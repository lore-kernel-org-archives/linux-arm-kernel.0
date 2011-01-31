From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Jan 2011 09:22:51 +0000
Subject: [PATCH V5 00/63] Updating SPEAr Support
In-Reply-To: <4D463B01.4050004@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<4D463B01.4050004@st.com>
Message-ID: <20110131092251.GA8729@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 31, 2011 at 10:00:57AM +0530, viresh kumar wrote:
> On 01/20/2011 12:55 PM, Viresh KUMAR wrote:
> > Following set of patches:
> > - updates SPEAr3xx, 6xx support
> > - Adds support for SPEAr13xx
> > - Removes Multiple defconfigs per machine family
> > 
> > Changes since V4:
> > - Following patch is added
> >   SPEAr: Defining IOMEM(x) and updating declaration of MISC_BASE
> > - variables referring to register now have type void __iomem *, instead of u32 *
> > - using linux/gpio.h instead of mach/gpio.h in *evb files.
> > - return value of clk_get(), and clk_get_sys are checked using IS_ERR().
> > - unused routines removed from headsmp.S
> > - spear13*_pcie_port_is_host routines are declared static
> > - platsmp.c updated according to review comments.
> > - Added clk_round_rate routine() and used it to check possible rate before
> >   calling cpufreq_notify_transition in cpufreq.c
> > - & removed before function names, while passing function pointer to other
> >   routines.
> > 
> 
> Russell,
> 
> Should I push these patches to tracker now ?

I've not yet been through them.  I only got part way through v4 before you
posted v5.
