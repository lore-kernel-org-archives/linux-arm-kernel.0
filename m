From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Apr 2013 16:51:28 -0600
Subject: [PATCH 1/3] ARM: tegra: fix build error when THUMB2_KERNEL enabled
In-Reply-To: <1366029749-16476-1-git-send-email-josephl@nvidia.com>
References: <1366029749-16476-1-git-send-email-josephl@nvidia.com>
Message-ID: <516C8470.5090007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2013 06:42 AM, Joseph Lo wrote:
> This patch fix the build failure when CONFIG_THUBM2_KERNEL enabled. You
> clould see the error message below:
> 
> arch/arm/mach-tegra/sleep-tegra30.S:69: Error: shift must be constant --
> `orr r12,r12,r4,lsl r3'

I have forwarded the series to the arm-soc maintainers to be applied
there. Thanks.
