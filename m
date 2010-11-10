From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Nov 2010 15:18:01 +0000
Subject: [PATCH 1/6 v4] ARM: Add basic architecture support for
	VIA/WonderMedia 85xx SoC's
In-Reply-To: <AANLkTinqpP8WN2h-kR7svZ6GZxi+0RMPBfPyMnzCpAuO@mail.gmail.com>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<20101107165745.GB1759@n2100.arm.linux.org.uk>
	<AANLkTimFJ=Brx4pDiUqZOKDfABaDg0s_yFC7EkZGi7D8@mail.gmail.com>
	<20101107171726.GF1759@n2100.arm.linux.org.uk>
	<20101108171930.GA1471@alchark-u3s.lan>
	<AANLkTinqpP8WN2h-kR7svZ6GZxi+0RMPBfPyMnzCpAuO@mail.gmail.com>
Message-ID: <20101110151801.GC24305@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 10, 2010 at 05:16:17PM +0200, saeed bishara wrote:
> > diff --git a/arch/arm/mach-vt8500/include/mach/uncompress.h b/arch/arm/mach-vt8500/include/mach/uncompress.h
> > new file mode 100644
> > index 0000000..bb9e2d2
> > --- /dev/null
> > +++ b/arch/arm/mach-vt8500/include/mach/uncompress.h
> > @@ -0,0 +1,37 @@
> > +/* arch/arm/mach-vt8500/include/mach/uncompress.h
> > + *
> > + * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
> > + *
> > + * Based on arch/arm/mach-dove/include/mach/uncompress.h
> please  replace dove with vt8500

That doesn't make sense - how can a file be created, based upon itself?
