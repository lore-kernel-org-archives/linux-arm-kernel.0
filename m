From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 07 Mar 2013 13:31:40 -0700
Subject: [PATCH] ARM: tegra: fix ignored return value of regulator_enable
In-Reply-To: <1362615385-13418-1-git-send-email-swarren@wwwdotorg.org>
References: <1362615385-13418-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5138F92C.2010107@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2013 05:16 PM, Stephen Warren wrote:
> This fixes:
> 
> arch/arm/mach-tegra/board-harmony-pcie.c: In function ?harmony_pcie_init?:
> arch/arm/mach-tegra/board-harmony-pcie.c:65:18: warning: ignoring return
>     value of ?regulator_enable?, declared with attribute
>     warn_unused_result [-Wunused-result]

I've applied this to Tegra's for-3.10/fixes branch.
