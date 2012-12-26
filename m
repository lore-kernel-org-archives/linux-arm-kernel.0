From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Wed, 26 Dec 2012 09:42:28 +0530
Subject: [PATCH v2 0/2] cpts fixes for v3.8-rc2
In-Reply-To: <cover.1356331925.git.richardcochran@gmail.com>
References: <cover.1356331925.git.richardcochran@gmail.com>
Message-ID: <50DA792C.1070603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/24/2012 12:49 PM, Richard Cochran wrote:
> Changed in v2:
> Use clk_prepare_enable instead of clk_prepare + clk_enable.
>
> The new cpts driver has two small issues, but it otherwise seems to be
> working in -rc1.
>
> Thanks,
> Richard
>
> Richard Cochran (2):
>    cpts: fix build error by removing useless code.
>    cpts: fix a run time warn_on.
>
>   drivers/net/ethernet/ti/cpts.c |    3 +--
>   drivers/net/ethernet/ti/cpts.h |    1 -
>   2 files changed, 1 insertions(+), 3 deletions(-)
>
Looks good to me.
Acked-by : Mugunthan V N <mugunthanvnm@ti.com>
