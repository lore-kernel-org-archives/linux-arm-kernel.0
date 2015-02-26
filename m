From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 26 Feb 2015 15:05:22 -0800
Subject: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
In-Reply-To: <20150226230052.GN8656@n2100.arm.linux.org.uk>
References: <54EB735F.5030207@upv.es>
 <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
 <20150223205436.15133mg1kpyojyik@webmail.upv.es>
 <20150224073906.GA16422@gmail.com>
 <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
 <20150226230052.GN8656@n2100.arm.linux.org.uk>
Message-ID: <20150226150522.1d0c035e631d4ea3aae924ec@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Feb 2015 23:00:52 +0000 Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Thu, Feb 26, 2015 at 02:38:15PM -0800, Andrew Morton wrote:
> > diff -puN arch/arm64/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/arm64/Kconfig
> > --- a/arch/arm64/Kconfig~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
> > +++ a/arch/arm64/Kconfig
> > @@ -1,4 +1,4 @@
> > -config ARM64
> > +qconfig ARM64
> 
> Is this a typo?

yup.  But the coffee's nice and strong.
