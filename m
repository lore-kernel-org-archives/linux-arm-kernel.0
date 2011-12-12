From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 12 Dec 2011 15:04:05 +0000
Subject: [PATCH v3 2/2] ARM: SMP: Refactor Kconfig to be more maintainable
In-Reply-To: <20111212141001.GZ14542@n2100.arm.linux.org.uk>
References: <1323690426-6267-1-git-send-email-dave.martin@linaro.org>
 <1323690426-6267-3-git-send-email-dave.martin@linaro.org>
 <20111212141001.GZ14542@n2100.arm.linux.org.uk>
Message-ID: <20111212150405.GB2296@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 02:10:01PM +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 12, 2011 at 11:47:06AM +0000, Dave Martin wrote:
> > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > index 4234937..4aa7f7e 100644
> > --- a/arch/arm/mach-imx/Kconfig
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -611,6 +611,7 @@ config SOC_IMX6Q
> >  	select ARM_GIC
> >  	select CPU_V7
> >  	select HAVE_ARM_SCU
> > +	select HAVE_SMP
> >  	select HAVE_IMX_GPC
> >  	select HAVE_IMX_MMDC
> >  	select HAVE_IMX_SRC
> 
> NAK.  I'll let you work out why.  It has something to do with ABCDEFGH...

Duh.  Sorry about that -- will fix and repost.


Do you have a preference about where to insert new items where the list
is not already in alphabetical order?

Currently, I've just tried not to make things worse than they already
are (except in this particular case...)

Cheers
---Dave
