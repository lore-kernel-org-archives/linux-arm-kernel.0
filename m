From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Jul 2018 10:43:33 +0100
Subject: [PATCH] MAINTAINERS: arm64: Remove boot/dts/ directory from
 arm64 entry
In-Reply-To: <CAMuHMdUqRXde5DNgK6ih+ivuwY9HFbcWwbx_x3q5PmFcrGi0pQ@mail.gmail.com>
References: <1530879736-7650-1-git-send-email-will.deacon@arm.com>
 <CAMuHMdUqRXde5DNgK6ih+ivuwY9HFbcWwbx_x3q5PmFcrGi0pQ@mail.gmail.com>
Message-ID: <20180711094333.GC13963@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Tue, Jul 10, 2018 at 09:25:58AM +0200, Geert Uytterhoeven wrote:
> On Fri, Jul 6, 2018 at 2:22 PM Will Deacon <will.deacon@arm.com> wrote:
> > The arm-soc tree does a good job handling .dts files, so exclude them
> > from the ARM64 entry in MAINTAINERS.
> >
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Thanks for your patch!
> 
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2264,6 +2264,7 @@ L:        linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
> >  S:     Maintained
> >  F:     arch/arm64/
> > +X:     arch/arm64/boot/dts/
> >  F:     Documentation/arm64/
> 
> Please note that this does not cause checkpatch to point to the arm-soc
> tree, but does drop the reference to linux-arm-kernel, which may not
> be intentional?

I think this is ok, since all of the individual sub-directories do pick
up the mailing list. Otherwise, somebody needs to claim responsibility
for the top-level directory, but realistically if you're adding a new
subdirectory there then you're going to be working with the right folks
anyway.

Will
