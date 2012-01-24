From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Tue, 24 Jan 2012 05:24:00 +0000
Subject: [RESEND PATCH] arm:davinci: prepare to move aemif driver to
 drivers/mfd
In-Reply-To: <20120123170436.GZ1068@n2100.arm.linux.org.uk>
References: <1327331552-9913-1-git-send-email-prakash.pm@ti.com>
 <20120123170436.GZ1068@n2100.arm.linux.org.uk>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3175A568@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King,

On Mon, Jan 23, 2012 at 22:34:36, Russell King - ARM Linux wrote:
> On Mon, Jan 23, 2012 at 08:42:32PM +0530, Manjunathappa, Prakash wrote:
> > Adding: MFD maintainer and mailing list.
> > 
> >  arch/arm/mach-davinci/aemif.c              |    2 +-
> >  arch/arm/mach-davinci/board-da830-evm.c    |    2 +-
> >  arch/arm/mach-davinci/board-da850-evm.c    |    2 +-
> >  arch/arm/mach-davinci/include/mach/aemif.h |   36 ----------------------------
> >  drivers/mtd/nand/davinci_nand.c            |    2 +-
> >  include/linux/mfd/davinci_aemif.h          |   36 ++++++++++++++++++++++++++++
> >  6 files changed, 40 insertions(+), 40 deletions(-)
> >  delete mode 100644 arch/arm/mach-davinci/include/mach/aemif.h
> >  create mode 100644 include/linux/mfd/davinci_aemif.h
> 
> As Linus has requested on many occasions, and it's a damned good
> idea, use -M when generating diffstat - and its also a *really* good
> idea to use -M if you're submitting patches which rename files for
> review as well.
> 
> Obviously arch/arm/mach-davinci/include/mach/aemif.h was moved to
> include/linux/mfd/davinci_aemif.h, but were there any changes to its
> contents?  Without -M, there only way of knowing is to compare each
> file line by line.  With -M, it'll tell us that it was renamed and
> produce a diff between the old and new location.
> 

Yes, I will make it a point to do this in next version and in future.

Thanks,
Prakash
