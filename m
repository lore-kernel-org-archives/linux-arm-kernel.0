From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Feb 2011 10:11:05 +0000
Subject: [PATCH] ARM: errata: pl310 cache sync operation may be faulty
In-Reply-To: <20110216050842.GB17274@bnru02>
References: <1297768683-30273-1-git-send-email-srinidhi.kasagar@stericsson.com>
	<AANLkTikPGwcm-_j-NzW2UixaEx_ekJMjJcrTO1SUy7Ao@mail.gmail.com>
	<20110216050842.GB17274@bnru02>
Message-ID: <1297851065.28844.29.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-02-16 at 05:08 +0000, Srinidhi KASAGAR wrote:
> On Tue, Feb 15, 2011 at 17:38:52 +0100, Catalin Marinas wrote:
> > On 15 February 2011 11:18, srinidhi kasagar
> > <srinidhi.kasagar@stericsson.com> wrote:
> > > +config ARM_ERRATA_753970
> > > +       bool "ARM errata: cache sync operation may be faulty"
> > > +       depends on CACHE_PL310
> > > +       help
> > > +         This option enables the workaround for the 753970 PL310 erratum.
> >
> > Is this number correct? I couldn't find it in ARM's internal database.
> 
> yes, we got this errata notice from ARM recently (10-feb-11), document
> revision 12.1

Ah, I found it (I was looking in the wrong place).

Catalin
