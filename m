From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Wed, 28 Oct 2015 12:59:37 +0530
Subject: [PATCHv2] i2c: cadence: Enable power management
In-Reply-To: <1446012279-2578-1-git-send-email-shubhraj@xilinx.com>
References: <1446012279-2578-1-git-send-email-shubhraj@xilinx.com>
Message-ID: <CAM=Q2cvOXPS8vCcgOzQiqHqWy28cCLHxa2e9uAwMhO_KdAfksw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 11:34 AM, Shubhrajyoti Datta
<shubhrajyoti.datta@xilinx.com> wrote:
> Currently the clocks are enabled at probe and disabled at remove.
> This patch enables the clocks at the start of transfer and disables
> after it.
>
> Also adapts to runtime pm.
> Remove xi2c->suspended and use pm runtime status instead.
>
> converts dev pm to const to silence a checkpatch warning.
>
Please ignore this patch
