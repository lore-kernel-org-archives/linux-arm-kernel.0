From: kraxel@redhat.com (Gerd Hoffmann)
Date: Fri, 03 Jun 2016 11:53:53 +0200
Subject: [PATCH v2 5/9] arm64: Add BCM2835 support to the defconfig.
In-Reply-To: <3299125.qWct7BqQgQ@wuerfel>
References: <1464934708-24769-1-git-send-email-kraxel@redhat.com>
 <1464934708-24769-6-git-send-email-kraxel@redhat.com>
 <3299125.qWct7BqQgQ@wuerfel>
Message-ID: <1464947633.24775.140.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Hi,

> > @@ -311,7 +329,6 @@ CONFIG_AUTOFS4_FS=y
> >  CONFIG_FUSE_FS=y
> >  CONFIG_CUSE=y
> >  CONFIG_VFAT_FS=y
> > -CONFIG_TMPFS=y
> >  CONFIG_HUGETLBFS=y
> >  CONFIG_CONFIGFS_FS=y
> >  CONFIG_EFIVAR_FS=y
> 
> Why?

That seems to come from enabling drm+vc4, probably something does
"select TMPFS".

cheers,
  Gerd
