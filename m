From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Feb 2016 10:11:18 +0100
Subject: [PATCH 03/10] arm64: add Armada 3700 architecture entry
In-Reply-To: <87k2mm5itx.fsf@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
 <20160203142451.41381ff6@xhacker> <87k2mm5itx.fsf@free-electrons.com>
Message-ID: <4284367.sAeqrVzAbo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 February 2016 08:55:22 Gregory CLEMENT wrote:
> >> 
> >> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> >> index 21074f674bde..7da341f7b90d 100644
> >> --- a/arch/arm64/Kconfig.platforms
> >> +++ b/arch/arm64/Kconfig.platforms
> >> @@ -1,5 +1,11 @@
> >>  menu "Platform selection"
> >>  
> >> +config ARCH_ARMADA_3700
> >
> > Would it be better to use ARCH_MVEBU? IMHO, there will be more ARMv8 SoCs
> > from our EBU, do we plan to add one CONFIG_ARMADA_yyzz for each SoC?
> 
> Not for each SoC but for each family, yes. As we did for the other mvebu
> SoC families.
> 

We tend to use a little more general config strings for arm64 than we have
for arm32. I think just using ARCH_MVEBU is fine here, no need to list
the 3700 series separately.

	Arnd
