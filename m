From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Mar 2013 11:35:48 -0600
Subject: [PATCH] ARM: tegra: Add sbs-battery node to Dalmore
In-Reply-To: <1363793492-2019-1-git-send-email-rklein@nvidia.com>
References: <1363793492-2019-1-git-send-email-rklein@nvidia.com>
Message-ID: <514C9674.905@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2013 09:31 AM, Rhyland Klein wrote:
> This patch adds the node for the bq20z45 I2C gas gauge which is
> compatible with the sbs-battery power supply driver.

Applied to Tegra's for-3.10/dt branch.

> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts

> +		battery: smart-battery at b {

I removed "@b" here, since the unit-address isn't necessary to make the
node name unique.
