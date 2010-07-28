From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 28 Jul 2010 11:45:42 +0200
Subject: [RFC 1/8] TILER-DMM: DMM-PAT driver for TI TILER
In-Reply-To: <513FF747EED39B4AADBB4D6C9D9F9F7903D644D974@dlee02.ent.ti.com>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com>
	<19F8576C6E063C45BE387C64729E7394044ED6384D@dbde02.ent.ti.com>
	<513FF747EED39B4AADBB4D6C9D9F9F7903D644D974@dlee02.ent.ti.com>
Message-ID: <201007281145.43450.laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 27 July 2010 21:05:11 Sin, David wrote:
> On Tuesday 27 July 2010 13:38:00 Hiremath, Vaibhav wrote:
> > On Saturday 24 July 2010 04:52:00 Sin, David wrote:
> > > 
> > > This patch adds support for DMM-PAT initialization and programming.
[snip]

> > > diff --git a/arch/arm/mach-omap2/include/mach/dmm.h b/arch/arm/mach-
> > > omap2/include/mach/dmm.h
> > > new file mode 100644
> > > index 0000000..68b798a
> > > --- /dev/null
> > > +++ b/arch/arm/mach-omap2/include/mach/dmm.h
> > > @@ -0,0 +1,128 @@

[snip]

> > > +#define DMM_PAT_STATUS__0     0x4C0
> > > +#define DMM_PAT_STATUS__1     0x4C4
> > > +#define DMM_PAT_STATUS__2     0x4C8
> > > +#define DMM_PAT_STATUS__3     0x4CC
> > > +#define DMM_PAT_DESCR__0      0x500
> > > +#define DMM_PAT_AREA__0       0x504
> > > +#define DMM_PAT_CTRL__0       0x508
> > > +#define DMM_PAT_DATA__0       0x50C
> > 
> > [Hiremath, Vaibhav] Not sure whether somebody has given same comment or
> > not, any specific reason behind double _ here?
> 
> [dhs] Yes -- this comment has been made already.  I'm using the same names
> defined in the TRM.  However, it can be changed.

If the TRM uses two underscores I'm fine with it.

-- 
Regards,

Laurent Pinchart
