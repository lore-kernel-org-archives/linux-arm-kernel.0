From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 28 May 2013 15:30:29 -0600
Subject: [PATCH] ARM: tegra: rebuild tegra_defconfig
In-Reply-To: <1369761972-31986-1-git-send-email-swarren@wwwdotorg.org>
References: <1369761972-31986-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <51A521F5.2010206@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2013 11:26 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This simply rebuilds tegra_defconfig on top of next-20130520. As such, it
> should introduce no changes; simply moving entries around due to Kconfig
> ordering changes. The apparent exceptions are:
> 
> AUTO_ZRELADDR: Selected by ARM multi-platform support.
> MTD_CHAR: Removed in Kconfig.
> 
> This should make it easier to create future defconfig patches on top of
> linux-next, since all the extraneous diffs have been removed. It also
> makes it more likely that once 3.12 comes around, this defconfig will
> already match what's required there.

I've applied this (squashed it into) Tegra's for-3.11/defconfig branch.
