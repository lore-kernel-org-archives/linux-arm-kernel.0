From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 21 May 2013 16:34:49 +0200
Subject: [PATCH v2 0/5] Zynq: revised CCF code
In-Reply-To: <1368467199-8702-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1368467199-8702-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <6d3d9b84-3438-4d74-9565-5c969e72b1df@CO9EHSMHS025.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2013 07:46 PM, Soren Brinkmann wrote:
> I rebased this series on v3.10-rc1 eliminating all dependencies and incorporated
> Greg's feedback.
> I'll push this also to my github repository.
> https://github.com/sorenb-xlnx/linux-xlnx/tree/zynq/clkc
> 
> v2:
>  - dropped the 'sort #includes' patches
> 
> 	S?ren
> 
> 
> Soren Brinkmann (5):
>   tty: xuartps: Remove suspend/resume functions

This patch will go through Greg trees.

>   clk: zynq: Factor out PLL driver
>   clk: zynq: Add clock controller driver
>   arm: zynq: Migrate platform to clock controller
>   clk: zynq: Remove deprecated clock code

I have added these patches to my arm-next branch
and also to zynq/clk branch.

Thanks,
Michal
