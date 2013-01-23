From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 23 Jan 2013 09:47:50 -0700
Subject: [PATCH v2 1/3] ARM: DT: tegra: move serial clock-frequency attr
 into the SoC dtsi
In-Reply-To: <1358891169-5939-1-git-send-email-dev@lynxeye.de>
References: <1358423961-24318-1-git-send-email-dev@lynxeye.de>
 <1358891169-5939-1-git-send-email-dev@lynxeye.de>
Message-ID: <51001436.5020506@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2013 02:46 PM, Lucas Stach wrote:
> No Tegra Platform is running PLL_P at another rate than 216MHz, nor is
> any using an other PLL as UART source clock. Move attribute into SoC
> level dtsi file to slim down board DT files.

I've applied the series to Tegra's for-3.9/dt branch.
