From: agross@codeaurora.org (Andy Gross)
Date: Thu, 23 Jul 2015 16:25:14 -0500
Subject: [PATCH 4/5] ARM: dts: qcom: Add ks8851 node for wired ethernet
In-Reply-To: <1434486676-21812-5-git-send-email-sboyd@codeaurora.org>
References: <1434486676-21812-1-git-send-email-sboyd@codeaurora.org>
 <1434486676-21812-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150723212514.GJ13658@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 01:31:15PM -0700, Stephen Boyd wrote:
> The micrel ks8851 device is present on MSM8960 CDP boards. It is
> connected to two regulators, one controlled via a gpio and
> another controlled via the RPM. Add the gsbi, spi, gpio
> regulator, and micrel ks8851 nodes so that ethernet works
> properly.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Applied, Thanks!

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
