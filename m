From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 12 Dec 2011 22:15:06 +0800
Subject: [PATCH 6/7] arm/imx6q: add cpufreq support
In-Reply-To: <20111212141031.GA14542@n2100.arm.linux.org.uk>
References: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
 <1323661352-10291-7-git-send-email-richard.zhao@linaro.org>
 <20111212141031.GA14542@n2100.arm.linux.org.uk>
Message-ID: <20111212141505.GF16835@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 02:10:31PM +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 12, 2011 at 11:42:31AM +0800, Richard Zhao wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---
> >  arch/arm/mach-imx/Kconfig        |    1 +
> >  arch/arm/mach-imx/Makefile       |    2 +-
> >  arch/arm/mach-imx/cpu_op-imx6q.c |   78 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 80 insertions(+), 1 deletions(-)
> >  create mode 100644 arch/arm/mach-imx/cpu_op-imx6q.c
> > 
> > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > index fbd414b..7d813a3 100644
> > --- a/arch/arm/mach-imx/Kconfig
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -837,6 +837,7 @@ config SOC_IMX6Q
> >  	select ARM_GIC
> >  	select CACHE_L2X0
> >  	select CPU_V7
> > +	select ARCH_HAS_CPUFREQ
> 
> ABCDEFGH...etc...
Right. Thanks for your comments.

Richard
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
