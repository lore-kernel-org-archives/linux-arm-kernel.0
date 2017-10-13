From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Oct 2017 10:11:42 +0100
Subject: [PATCH v8 0/4] Add support for ThunderX2 pmu events using json
 files
In-Reply-To: <CAKTKpr6RCzq3QhgptZECZG=YoEmTWCEhM2QaHpzx-ZEtactbHQ@mail.gmail.com>
References: <20171012141116.32475-1-ganapatrao.kulkarni@cavium.com>
 <20171012152402.GC5614@arm.com>
 <CAKTKpr6RCzq3QhgptZECZG=YoEmTWCEhM2QaHpzx-ZEtactbHQ@mail.gmail.com>
Message-ID: <20171013091141.GA11429@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 12, 2017 at 10:54:50PM +0530, Ganapatrao Kulkarni wrote:
> On Thu, Oct 12, 2017 at 8:54 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Oct 12, 2017 at 07:41:12PM +0530, Ganapatrao Kulkarni wrote:
> >> Extending json/jevent framework for parsing arm64 event files.
> >> Adding jevents for ThunderX2 implementation defined PMU events.
> >>
> >> v8:
> >>    - Rename thunderx2 directory to cavium
> >
> > For the series:
> >
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> thanks.
> >
> > Although note that this conflicts against a queued fix from Mark[1], so
> > you'll need to rebase on top of that.
> 
> sure, will do.
> may i know the branch/repo which i can rebase to?

Arnaldo said he was going to apply it to his perf/urgent branch [1],
although I can't spot it there yet. I'm also not sure whether that's the
right thing on which to base 4.15 material. Arnaldo -- what's the best
thing to do here?

Cheers,

Will

[1] http://lkml.kernel.org/r/20171009190000.GL2121 at redhat.com
