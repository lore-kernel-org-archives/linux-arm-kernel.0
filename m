From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 7 Jan 2015 11:03:18 +0000
Subject: [PATCH] ARM: vexpress_defconfig: enable ACL and security labels
 for ext4
In-Reply-To: <87fvbmubqq.fsf%l.stelmach@samsung.com>
References: <1418383877-29685-1-git-send-email-l.stelmach@samsung.com>
 <3238168.YKYh95mZKp@wuerfel>
 <87fvbmubqq.fsf%l.stelmach@samsung.com>
Message-ID: <20150107110318.GA29344@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 10:27:25AM +0000, ?ukasz Stelmach wrote:
> It was <2014-12-12 pi? 12:38>, when Arnd Bergmann wrote:
> > On Friday 12 December 2014 12:31:17 ?ukasz Stelmach wrote:
> >> This patch enables security features of ext4 file-system required
> >> by many conteporary user-space setups.
> >> 
> >> Signed-off-by: ?ukasz Stelmach <l.stelmach@samsung.com>
> >> ---
> >>  arch/arm/configs/vexpress_defconfig | 2 ++
> >>  1 file changed, 2 insertions(+)
> >
> > The patch looks good, but should be addressed to the vexpress maintainers
> > (Liviu, Sudeep, Lorenzo)
> >
> > 	Arnd
> 
> ...?
> ping?

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310300.html

Lorenzo

> >> diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
> >> index f489fda..1d9dd6e 100644
> >> --- a/arch/arm/configs/vexpress_defconfig
> >> +++ b/arch/arm/configs/vexpress_defconfig
> >> @@ -138,6 +138,8 @@ CONFIG_EXT3_FS=y
> >>  # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
> >>  # CONFIG_EXT3_FS_XATTR is not set
> >>  CONFIG_EXT4_FS=y
> >> +CONFIG_EXT4_FS_POSIX_ACL=y
> >> +CONFIG_EXT4_FS_SECURITY=y
> >>  CONFIG_VFAT_FS=y
> >>  CONFIG_TMPFS=y
> >>  CONFIG_JFFS2_FS=y
> 
> -- 
> ?ukasz Stelmach
> Samsung R&D Institute Poland
> Samsung Electronics
