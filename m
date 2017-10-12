From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Oct 2017 11:58:52 +0100
Subject: [PATCH v7 0/4] Add support for ThunderX2 pmu events using json
 files
In-Reply-To: <CAKTKpr5=msG9b-f2Mj+1SibUvMXefg9DAcNA7M3hgHCX=hpQ6g@mail.gmail.com>
References: <20171012103419.29824-1-ganapatrao.kulkarni@cavium.com>
 <20171012103820.GC17924@rric.localdomain>
 <CAKTKpr5=msG9b-f2Mj+1SibUvMXefg9DAcNA7M3hgHCX=hpQ6g@mail.gmail.com>
Message-ID: <20171012105851.GC7395@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 12, 2017 at 04:20:06PM +0530, Ganapatrao Kulkarni wrote:
> Hi Robert,
> 
> On Thu, Oct 12, 2017 at 4:08 PM, Robert Richter <rric@kernel.org> wrote:
> > On 12.10.17 16:04:15, Ganapatrao Kulkarni wrote:
> >
> >>  tools/perf/arch/arm64/util/Build                   |  1 +
> >>  tools/perf/arch/arm64/util/header.c                | 65 ++++++++++++++++++++++
> >>  tools/perf/arch/powerpc/util/header.c              |  2 +-
> >>  tools/perf/arch/x86/util/header.c                  |  2 +-
> >>  tools/perf/pmu-events/arch/arm64/mapfile.csv       | 15 +++++
> >>  .../arch/arm64/thunderx2/thunderx2-imp-def.json    | 62 +++++++++++++++++++++
> >
> > I guess the dir needs to be named 'cavium'.
> 
> i dont think so ,  while compilation arch type is detected, it has to be arm64
> refer SRCARCH in pmu-events/Build

The full name should be:

.../arch/arm64/cavium/thunderx2-imp-def.json

Will
