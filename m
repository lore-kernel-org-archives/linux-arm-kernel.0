From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 23 Jan 2013 09:57:49 -0700
Subject: [PATCH] ARM: tegra: move serial clock-frequency attr into the
 Tegra30 dtsi
In-Reply-To: <1358960222-22705-1-git-send-email-swarren@wwwdotorg.org>
References: <1358960222-22705-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5100168D.4090305@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2013 09:57 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> No Tegra30 Platform is running PLL_P at another rate than 408MHz, nor is
> any using any other PLL as UART source clock. Move attribute into SoC
> level dtsi file to slim down board DT files.

I have applied this to Tegra's for-3.9/dt branch.
