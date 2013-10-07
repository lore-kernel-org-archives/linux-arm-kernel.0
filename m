From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 07 Oct 2013 13:22:45 -0600
Subject: [PATCH] ARM: tegra: fix ARCH_TEGRA_114_SOC select sort order
In-Reply-To: <1381173105-17971-1-git-send-email-swarren@wwwdotorg.org>
References: <1381173105-17971-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <52530A05.6000606@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2013 01:11 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> All the other select statements are alphabetically sorted. Fix the one
> remaining escape.

Applied to Tegra's for-3.13/cleanup branch.
