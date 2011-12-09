From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 9 Dec 2011 17:52:03 +0200
Subject: [PATCH v6 10/10] arm/tegra: add support for tegra30 based
 board cardhu
In-Reply-To: <4EE21B67.5040006@gmail.com>
References: <1323348254-29072-1-git-send-email-pdeschrijver@nvidia.com>
 <1323348254-29072-11-git-send-email-pdeschrijver@nvidia.com>
 <4EE21B67.5040006@gmail.com>
Message-ID: <20111209155203.GM27578@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >  choice
> >          prompt "Low-level debug console UART"
> >          default TEGRA_DEBUG_UART_NONE
> > diff --git a/arch/arm/mach-tegra/Makefile.boot b/arch/arm/mach-tegra/Makefile.boot
> > index cf51a00..7c1110f 100644
> > --- a/arch/arm/mach-tegra/Makefile.boot
> > +++ b/arch/arm/mach-tegra/Makefile.boot
> > @@ -7,3 +7,4 @@ dtb-$(CONFIG_MACH_PAZ00) += tegra-paz00.dtb
> >  dtb-$(CONFIG_MACH_SEABOARD) += tegra-seaboard.dtb
> >  dtb-$(CONFIG_MACH_TRIMSLICE) += tegra-trimslice.dtb
> >  dtb-$(CONFIG_MACH_VENTANA) += tegra-ventana.dtb
> > +dtb-$(CONFIG_MACH_CARDHU) += tegra-cardhu.dtb
> 
> Likewise, this should be more like:
> dtb-$(CONFIG_MACH_TEGRA_DT) += tegra-seaboard.dtb tegra-trimslice.dtb
> tegra-ventana.dtb ...
> 

I think is subject of a different patch.

Cheers,

Peter.
