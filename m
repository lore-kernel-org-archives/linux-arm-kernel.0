From: rric@kernel.org (Robert Richter)
Date: Thu, 12 Oct 2017 12:38:20 +0200
Subject: [PATCH v7 0/4] Add support for ThunderX2 pmu events using json
 files
In-Reply-To: <20171012103419.29824-1-ganapatrao.kulkarni@cavium.com>
References: <20171012103419.29824-1-ganapatrao.kulkarni@cavium.com>
Message-ID: <20171012103820.GC17924@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.10.17 16:04:15, Ganapatrao Kulkarni wrote:

>  tools/perf/arch/arm64/util/Build                   |  1 +
>  tools/perf/arch/arm64/util/header.c                | 65 ++++++++++++++++++++++
>  tools/perf/arch/powerpc/util/header.c              |  2 +-
>  tools/perf/arch/x86/util/header.c                  |  2 +-
>  tools/perf/pmu-events/arch/arm64/mapfile.csv       | 15 +++++
>  .../arch/arm64/thunderx2/thunderx2-imp-def.json    | 62 +++++++++++++++++++++

I guess the dir needs to be named 'cavium'.

-Robert

>  tools/perf/util/header.h                           |  3 +-
>  tools/perf/util/pmu.c                              | 52 +++++++++++++----
>  8 files changed, 189 insertions(+), 13 deletions(-)
