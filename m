From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 15 Feb 2017 11:59:59 -0700
Subject: [PATCH 0/2] coresight: Replace sprintf with scnprintf + bug fix
In-Reply-To: <20170215022029.21744-1-ohaugan@codeaurora.org>
References: <20170215022029.21744-1-ohaugan@codeaurora.org>
Message-ID: <CANLsYkzrYypT8tk0ttiELfMgxKntFwMG2KMfEB1TKJ9WHbVHKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 February 2017 at 19:20, Olav Haugan <ohaugan@codeaurora.org> wrote:
> Replaced all occurrences of s{n}printf with scnprintf for consistency
> across coresight files.
> While doing that found a bug in one of the show functions which I also
> fixed (second patch).
>
> Olav Haugan (2):
>   coresight: Replace sprintf with scnprintf
>   coresight: etm3x: Correctly output counter values in sysfs node
>
>  drivers/hwtracing/coresight/coresight-etb10.c      |  2 +-
>  drivers/hwtracing/coresight/coresight-etm-perf.c   |  2 +-
>  .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 80 ++++++++++++----------
>  drivers/hwtracing/coresight/coresight-funnel.c     |  4 +-
>  drivers/hwtracing/coresight/coresight-stm.c        |  2 +-
>  drivers/hwtracing/coresight/coresight-tmc.c        |  2 +-
>  6 files changed, 51 insertions(+), 41 deletions(-)
>

I have applied both patches - thanks,
Mathieu

> --
> 2.11.0
>
