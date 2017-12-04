From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Mon, 4 Dec 2017 12:09:43 -0300
Subject: [PATCH v9 0/5] Add support for ThunderX2 pmu events using json
 files
In-Reply-To: <CAKTKpr6kyfbmOcy3JNzQkefN+yhQrvu_2McZU=q=tK3_1G6tyg@mail.gmail.com>
References: <20171016183222.25750-1-ganapatrao.kulkarni@cavium.com>
 <20171107012355.GC13514@arm.com>
 <f01a7071-7db9-973c-1ac1-c37e4559c5cf@huawei.com>
 <CAKTKpr6kyfbmOcy3JNzQkefN+yhQrvu_2McZU=q=tK3_1G6tyg@mail.gmail.com>
Message-ID: <20171204150943.GA13698@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Mon, Dec 04, 2017 at 10:11:01AM +0530, Ganapatrao Kulkarni escreveu:
> Hi perf maintainers,
> 
> can this be queued to -next??
> please let me know, if have to rebase to any specific branch and send
> next version?

I went over the messages and saw the acks, will try and process it now.

Sorry for the delay, it fell thru the cracks :-\

- Arnaldo
 
> 
> On Mon, Nov 27, 2017 at 3:34 PM, John Garry <john.garry@huawei.com> wrote:
> > On 07/11/2017 01:23, Will Deacon wrote:
> >>
> >> Hi Arnaldo,
> >>
> >> On Tue, Oct 17, 2017 at 12:02:17AM +0530, Ganapatrao Kulkarni wrote:
> >>>
> >>> Extending json/jevent framework for parsing arm64 event files.
> >>> Adding jevents for ThunderX2 implementation defined PMU events.
> >>>
> >>> v9:
> >>>    - Rebased to [3] and resolved conficts in PATCH 1/5 and reworked PATCH
> >>> 3/5.
> >>>    - Added PATCH 5 to fix segmentation fault in perf_pmu__find_map
> >>>
> >>> [3]
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf/core
> >>
> >>
> >> I'm happy with this version of the series (it's all Acked now), so would
> >> you
> >> be able to pick it up for mainline, please?
> >>
> >> Cheers,
> >>
> >
> > So this patchset has not been merged.
> >
> > We have a patchset waiting for HiSilicon hip08 support, which includes the
> > requested feature for the ARM64 IMP DEFINED recommended events
> > refactoring-out.
> >
> > We can send our hip08 patchset now as an RFC, based in this patchset.
> > Depending on the comments and general acceptance of the approaches, it may
> > be appropriate to merge the patchsets (or at least merge the refactoring
> > part).
> >
> > Thanks,
> > John
> >
> >
> >> Will
> >>
> >> .
> >>
> >
> >
> 
> thanks
> Ganapat
