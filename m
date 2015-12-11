From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 11 Dec 2015 19:42:33 +0800
Subject: [PATCH v2] ARM: multi_v7_defconfig: Enable some drivers for
 LS1021A
In-Reply-To: <5410635.RmBCMMyZr3@wuerfel>
References: <1449650499-28660-1-git-send-email-b18965@freescale.com>
 <5410635.RmBCMMyZr3@wuerfel>
Message-ID: <20151211114233.GG11252@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2015 at 09:57:26AM +0100, Arnd Bergmann wrote:
> On Wednesday 09 December 2015 16:41:39 Alison Wang wrote:
> > This patch enables some drivers for LS1021A, such as
> > GIANFAR, WATCHDOG, AUDIO, QSPI, I2C, ESDHC, EDMA, FTM.
> > QorIQ Clock Framework and Ramdisk support is also enabled.
> > 
> > Signed-off-by: Alison Wang <alison.wang@freescale.com>
> > ---
> > Changes since v1:
> > - Make some drivers as loadable modules.
> > 
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Shawn, do you want to pick this up and send it back through the
> imx tree?
> 
> If you have no other defconfig changes for 4.5, we can also just
> add it to arm-soc.

Arnd,

I was told by Olof to stay away from multi_v7_defconfig as it's not i.MX
specific.  So please apply it directly to arm-soc.

Shawn
