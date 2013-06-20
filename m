From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 14:52:33 +0200
Subject: [PATCH] irqchip: gic: call gic_cpu_init() as well in
 CPU_STARTING_FROZEN case
In-Reply-To: <1371694169.2155.12.camel@jlo-ubuntu-64.nvidia.com>
References: <1371036627-13529-1-git-send-email-shawn.guo@linaro.org>
 <20130619070253.GA3405@S2101-09.ap.freescale.net>
 <1371694169.2155.12.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <201306201452.33884.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 June 2013, Joseph Lo wrote:
> > > 
> > > Can you please send the fix for 3.10?  Or are you fine with that I ask
> > > arm-soc folks to send it?
> > 
> > Arnd, Olof,
> > 
> > Can you help send the fix for 3.10?
> > 
> Shawn's patch fix the suspend/resume regression for Tegra also.
> 
> Tested-by: Joseph Lo <josephl@nvidia.com>

Applied to fixes branch.

	Arnd
