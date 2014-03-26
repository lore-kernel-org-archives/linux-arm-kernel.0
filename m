From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Mar 2014 23:17:53 +0100
Subject: [PATCH] ARM: update multi_v7_defconfig for Tegra
In-Reply-To: <1395435418-1376-1-git-send-email-swarren@wwwdotorg.org>
References: <1395435418-1376-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201403262317.53217.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 March 2014, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This patch adds the same options to multi_v7_defconfig as were added to
> tegra_defconfig in commit d1c912c1001f "ARM: tegra: defconfig updates".
> (CONFIG_POWER_RESET_AS3722 is already enabled here.)
> 
> Suggested-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied on next/boards branch

	Arnd
