From: davidb@codeaurora.org (David Brown)
Date: Mon, 19 Dec 2011 15:22:03 -0800
Subject: [PATCH 20/20] ARM: big removal of now unused arch_reset()
In-Reply-To: <1324288069-21940-21-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
 <1324288069-21940-21-git-send-email-nico@fluxnic.net>
Message-ID: <20111219232203.GB9896@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 04:47:49AM -0500, Nicolas Pitre wrote:
> When this is the only content remaining in mach/system.h then the
> whole file is removed.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

>  arch/arm/mach-msm/include/mach/system.h        |    4 ---

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
