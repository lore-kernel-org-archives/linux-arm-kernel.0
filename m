From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 11 Aug 2016 15:19:48 -0700
Subject: [PATCH v2] arm64: dts: qcom: Fix broken interrupt trigger settings
In-Reply-To: <1470937850-10492-1-git-send-email-marc.zyngier@arm.com>
References: <1470937850-10492-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160811221948.GL2996@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11, Marc Zyngier wrote:
> When a device uses the GIC as its interrupt controller and generates
> SPIs, only the values 1 (edge rising) and 4 (level high) are legal.
> 
> Anything else is just plain wrong (can't be programmed into the HW),
> and leads to aborted driver probes (USB doesn't work with 4.8-rc1
> on a Dragonboard 410C).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
