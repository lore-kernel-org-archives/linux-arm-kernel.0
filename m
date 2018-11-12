From: roy.pledge@nxp.com (Roy Pledge)
Date: Mon, 12 Nov 2018 16:03:08 +0000
Subject: [PATCH 0/2] soc: fsl: dpio: cleanup on the remove path
References: <1541410219-9943-1-git-send-email-ioana.ciornei@nxp.com>
Message-ID: <DB6PR0402MB2727CB4ED8267C5CED85B65786C10@DB6PR0402MB2727.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/5/2018 4:30 AM, Ioana Ciornei wrote:
> This patch series cleans up the remove path in the dpio driver so that
> successive bind/unbind commands behave properly.
>
> Ioana Ciornei (2):
>   soc: fsl: dpio: cleanup the cpu array on dpaa2_io_down
>   soc: fsl: dpio: use a cpumask to identify which cpus are unused
>
>  drivers/soc/fsl/dpio/dpio-driver.c  | 25 ++++++++++++++++---------
>  drivers/soc/fsl/dpio/dpio-service.c | 11 +++++++++++
>  include/soc/fsl/dpaa2-io.h          |  2 ++
>  3 files changed, 29 insertions(+), 9 deletions(-)
>
Reviewed-by: Roy Pledge <roy.pledge@nxp.com>
