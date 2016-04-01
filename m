From: oss@buserror.net (Scott Wood)
Date: Fri, 01 Apr 2016 17:25:43 -0500
Subject: [v7, 0/5] Fix eSDHC host version register bug
In-Reply-To: <1459480051-3701-1-git-send-email-yangbo.lu@nxp.com>
References: <1459480051-3701-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1459549543.32510.28.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-04-01 at 11:07 +0800, Yangbo Lu wrote:
> This patchset is used to fix a host version register bug in the T4240-R1.0
> -R2.0
> eSDHC controller. To get the SoC version and revision, it's needed to add
> the
> GUTS driver to access the global utilities registers.
> 
> So, the first three patches are to add the GUTS driver.
> The following two patches are to enable GUTS driver support to get SVR in
> eSDHC
> driver and fix host version for T4240.
> 
> Yangbo Lu (5):
>   ARM64: dts: ls2080a: add device configuration node
>   soc: fsl: add GUTS driver for QorIQ platforms
>   dt: move guts devicetree doc out of powerpc directory
>   powerpc/fsl: move mpc85xx.h to include/linux/fsl
>   mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0

Acked-by: Scott Wood <oss@buserror.net>

-Scott
