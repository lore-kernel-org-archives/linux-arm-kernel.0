From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 1 Nov 2011 15:37:47 +0200
Subject: [PATCH 3/6] arm/tegra: prepare early init for multiple tegra
	variants
In-Reply-To: <20111028161933.GK23539@mudshark.cambridge.arm.com>
References: <1319561644-6160-1-git-send-email-pdeschrijver@nvidia.com>
	<1319561644-6160-4-git-send-email-pdeschrijver@nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173E1B49B2@HQMAIL01.nvidia.com>
	<20111027201657.GP19187@n2100.arm.linux.org.uk>
	<20111028161933.GK23539@mudshark.cambridge.arm.com>
Message-ID: <20111101133747.GF13358@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2011 at 06:19:34PM +0200, Will Deacon wrote:
> On Thu, Oct 27, 2011 at 09:16:57PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Oct 27, 2011 at 01:06:13PM -0700, Stephen Warren wrote:
> > > Peter De Schrijver wrote at Tuesday, October 25, 2011 10:54 AM:
> > > > -static __initdata struct tegra_clk_init_table common_clk_init_table[] = {
> > > > +void (*arch_reset)(char mode, const char *cmd) = tegra_assert_system_reset;
> > > 
> > > I'm not sure why you moved that, but I suppose it's fine.
> > 
> > Note that Nicolas has a patch set during KS which cleans the arch_reset
> > business out of mach/system.h, and effectively gets rid of arch_reset
> > entirely, so this probably conflicts with those changes.
> 
> I've spammed the ARM list with this patch series now, so the state of the
> conflicts should be evident.
> 

Will be taken into account in the next version.

Chers,

Peter.
