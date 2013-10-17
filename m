From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 17 Oct 2013 11:16:26 +0100
Subject: [PATCH 2/2] ARM: vexpress: Enable platform-specific options in
 defconfig
In-Reply-To: <525ED38C.9040700@codeaurora.org>
References: <1381930594-1701-1-git-send-email-pawel.moll@arm.com>
 <1381930594-1701-3-git-send-email-pawel.moll@arm.com>
 <525ED38C.9040700@codeaurora.org>
Message-ID: <1382004986.27517.109.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-10-16 at 18:57 +0100, Christopher Covington wrote:
> > @@ -121,21 +141,20 @@ CONFIG_EXT4_FS=y
> >  CONFIG_VFAT_FS=y
> >  CONFIG_TMPFS=y
> >  CONFIG_JFFS2_FS=y
> > +CONFIG_UBIFS_FS=y
> >  CONFIG_CRAMFS=y
> > +CONFIG_SQUASHFS=y
> > +CONFIG_SQUASHFS_LZO=y
> >  CONFIG_NFS_FS=y
> > -CONFIG_NFS_V3=y
> >  CONFIG_ROOT_NFS=y
> 
> Isn't CONFIG_9P_FS=y needed for VirtIO passthrough filesystem support?

Yes, I think you're right. I've expected 9P_VFS and NET_9P select or
depend on each other.

Thanks for pointing this out!

Pawe?
