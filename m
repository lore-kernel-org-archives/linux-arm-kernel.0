From: robert.richter@cavium.com (Robert Richter)
Date: Tue, 29 Aug 2017 14:47:30 +0200
Subject: [PATCH v6 4/4] perf vendor events arm64: Add ThunderX2
 implementation defined pmu core events
In-Reply-To: <43dcc107-263a-5429-73d4-a5290c6610d6@hisilicon.com>
References: <20170824120349.2323-1-ganapatrao.kulkarni@cavium.com>
 <20170824120349.2323-5-ganapatrao.kulkarni@cavium.com>
 <43dcc107-263a-5429-73d4-a5290c6610d6@hisilicon.com>
Message-ID: <20170829124730.GH17961@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shaokun,

On 29.08.17 17:26:00, Zhangshaokun wrote:
> On 2017/8/24 20:03, Ganapatrao Kulkarni wrote:
> > This is not a full event list, but a short list of useful events.
> > 
> > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > ---
> >  tools/perf/pmu-events/arch/arm64/mapfile.csv       | 15 ++++++
> >  .../arm64/thunderx2/implementation-defined.json    | 62 ++++++++++++++++++++++
> >  2 files changed, 77 insertions(+)
> >  create mode 100644 tools/perf/pmu-events/arch/arm64/mapfile.csv
> >  create mode 100644 tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json
> > 
> 
> I saw you also used thunderx2 in tools/perf/pmu-events/arch/arm64/, how about John's suggestion
> that would use vendor sub-folder?
> Of course, appreciate maintainer's comments.

this would just add another level of subdirectories. I rather would
prefer to have a per platform dir comparable to what is listed in

 arch/arm64/Kconfig.platforms

This is the same as Ganapat has implemented it.

-Robert
