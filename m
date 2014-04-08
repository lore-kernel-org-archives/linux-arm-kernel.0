From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 7 Apr 2014 17:33:04 -0700
Subject: [PATCH v2] clk: qcom: Add support for IPQ8064's global clock
 controller (GCC)
In-Reply-To: <1396642749-12979-1-git-send-email-galak@codeaurora.org>
References: <1396642749-12979-1-git-send-email-galak@codeaurora.org>
Message-ID: <20140408003304.GK9985@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04, Kumar Gala wrote:
> Add a driver for the global clock controller found on IPQ8064 based
> platforms. This should allow most non-multimedia device drivers to probe
> and control their clocks.
> 
> This is currently missing clocks for SATA, USB, and networking devices.
> 
> Signed-off-by: Kumar Gala <galak@codeaurora.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
