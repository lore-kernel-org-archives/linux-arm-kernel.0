From: will.deacon@arm.com (Will Deacon)
Date: Tue, 7 Nov 2017 01:23:55 +0000
Subject: [PATCH v9 0/5] Add support for ThunderX2 pmu events using json
 files
In-Reply-To: <20171016183222.25750-1-ganapatrao.kulkarni@cavium.com>
References: <20171016183222.25750-1-ganapatrao.kulkarni@cavium.com>
Message-ID: <20171107012355.GC13514@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaldo,

On Tue, Oct 17, 2017 at 12:02:17AM +0530, Ganapatrao Kulkarni wrote:
> Extending json/jevent framework for parsing arm64 event files.
> Adding jevents for ThunderX2 implementation defined PMU events.
> 
> v9:
>    - Rebased to [3] and resolved conficts in PATCH 1/5 and reworked PATCH 3/5.
>    - Added PATCH 5 to fix segmentation fault in perf_pmu__find_map
> 
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf/core

I'm happy with this version of the series (it's all Acked now), so would you
be able to pick it up for mainline, please?

Cheers,

Will
