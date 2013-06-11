From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Jun 2013 22:24:55 +0200
Subject: [PATCH 1/3] ARM: keystone: Add minimal TI Keystone platform
 support
In-Reply-To: <51B78438.6090604@ti.com>
References: <1370894123-26846-1-git-send-email-santosh.shilimkar@ti.com>
 <3148358.YM4iO29jiR@wuerfel> <51B78438.6090604@ti.com>
Message-ID: <1884655.zPfOkDCsbu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 June 2013 16:10:32 Santosh Shilimkar wrote:
> On Tuesday 11 June 2013 03:27 PM, Arnd Bergmann wrote:
> > On Monday 10 June 2013 15:55:21 Santosh Shilimkar wrote:
> >>
> >> diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
> >> new file mode 100644
> >> index 0000000..62e968c
> >> --- /dev/null
> >> +++ b/arch/arm/configs/keystone_defconfig
> >> @@ -0,0 +1,157 @@
> >> +# CONFIG_SWAP is not set
> >> +CONFIG_POSIX_MQUEUE=y
> >> +CONFIG_HIGH_RES_TIMERS=y
> >> +CONFIG_IKCONFIG=y
> > 
> > How about adding the things you need to multi_v7_defconfig instead?
> > We try not to have too many defconfigs.
> >
> I initially thought about it but after looking at various subsystems needed
> (from internal trees), we will need to 1 custom defoconfig and my plan
> is to limit to only one for all Keystone machines.

Ok, fair enough. Could you enable keystone in multi_v7_defconfig anyway
and ensure that it is able to boot?

	Arnd
