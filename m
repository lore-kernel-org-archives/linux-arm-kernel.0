From: davidb@codeaurora.org (David Brown)
Date: Mon, 13 Feb 2012 15:05:13 -0800
Subject: [PATCH 05/15] ARM: msm: use runtime ioremap hook
In-Reply-To: <1329169408-17253-6-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <1329169408-17253-6-git-send-email-robherring2@gmail.com>
Message-ID: <20120213230512.GB10827@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 03:43:18PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Convert msm platforms to use run-time ioremap hook instead of the compile
> time hook.
> 
> According to David Brown, only the msm7201 needed the ioremap hook.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/mach-msm/board-halibut.c               |    6 ++++++
>  arch/arm/mach-msm/board-trout.c                 |    6 ++++++
>  arch/arm/mach-msm/include/mach/io.h             |    5 -----
>  arch/arm/mach-msm/include/mach/msm_iomap-7x00.h |    6 ++++++
>  arch/arm/mach-msm/io.c                          |    1 -
>  5 files changed, 18 insertions(+), 6 deletions(-)

Tested on 8660, compiled on all MSM targets (both patches that apply
to msm).

Tetsed-by: David Brown <davidb@codeaurora.org>
Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
