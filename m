From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 12 Dec 2014 11:52:15 +0000
Subject: [PATCH] ARM: vexpress_defconfig: enable ACL and security labels
 for ext4
In-Reply-To: <3238168.YKYh95mZKp@wuerfel>
References: <1418383877-29685-1-git-send-email-l.stelmach@samsung.com>
 <3238168.YKYh95mZKp@wuerfel>
Message-ID: <20141212115215.GJ821@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 12, 2014 at 11:38:33AM +0000, Arnd Bergmann wrote:
> On Friday 12 December 2014 12:31:17 ?ukasz Stelmach wrote:
> > This patch enables security features of ext4 file-system required
> > by many conteporary user-space setups.
> > 
> > Signed-off-by: ?ukasz Stelmach <l.stelmach@samsung.com>
> > ---
> >  arch/arm/configs/vexpress_defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> The patch looks good, but should be addressed to the vexpress maintainers
> (Liviu, Sudeep, Lorenzo)
> 
> 	Arnd

Looks good to me.

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

> 
> > diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
> > index f489fda..1d9dd6e 100644
> > --- a/arch/arm/configs/vexpress_defconfig
> > +++ b/arch/arm/configs/vexpress_defconfig
> > @@ -138,6 +138,8 @@ CONFIG_EXT3_FS=y
> >  # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
> >  # CONFIG_EXT3_FS_XATTR is not set
> >  CONFIG_EXT4_FS=y
> > +CONFIG_EXT4_FS_POSIX_ACL=y
> > +CONFIG_EXT4_FS_SECURITY=y
> >  CONFIG_VFAT_FS=y
> >  CONFIG_TMPFS=y
> >  CONFIG_JFFS2_FS=y
> > 
> 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
