From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 02 Sep 2014 19:38:44 -0700
Subject: [PATCH 0/3] clk: zynq: Clean up
In-Reply-To: <1409698929-30143-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1409698929-30143-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <20140903023844.5251.5476@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Soren Brinkmann (2014-09-02 16:02:06)
> Hi,
> 
> triggered by that discussion whether checkpatch should be used to check
> files, I ran checkpatch on Zynq's clock code. A few of the reported
> issues I found worth fixing.

Applied to clk-next.

Regards,
Mike

> 
>         Thanks,
>         S?ren
> 
> Soren Brinkmann (3):
>   clk: zynq: Remove unnecessary OOM message
>   clk: zynq: Remove pointless return at end of void function
>   clk: zynq: Move const initdata into correct code section
> 
>  drivers/clk/zynq/clkc.c | 30 ++++++++++++++----------------
>  drivers/clk/zynq/pll.c  |  4 +---
>  2 files changed, 15 insertions(+), 19 deletions(-)
> 
> -- 
> 2.1.0.1.g27b9230
> 
