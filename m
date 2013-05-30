From: davidb@codeaurora.org (David Brown)
Date: Thu, 30 May 2013 09:42:48 -0700
Subject: [PATCH 7/8] ARM: msm: use generic cpu idle function for wfi
In-Reply-To: <1369665166-13049-8-git-send-email-sanjay.rawat@linaro.org>
References: <1369665166-13049-1-git-send-email-sanjay.rawat@linaro.org>
 <1369665166-13049-8-git-send-email-sanjay.rawat@linaro.org>
Message-ID: <20130530164248.GA10404@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 27, 2013 at 08:02:44PM +0530, Sanjay Singh Rawat wrote:
>use cpu_do_idle for entering the wfi mode.
>
>Signed-off-by: Sanjay Singh Rawat <sanjay.rawat@linaro.org>
>---
> arch/arm/mach-msm/hotplug.c |    9 ++-------
> 1 file changed, 2 insertions(+), 7 deletions(-)

Acked-by: David Brown <davidb@codeaurora.org>

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
