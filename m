From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 17 Sep 2013 14:05:12 -0600
Subject: [PATCH 0/7] ARM: tegra: various misc cleanups
In-Reply-To: <1379096711-26875-1-git-send-email-swarren@wwwdotorg.org>
References: <1379096711-26875-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5238B5F8.4010908@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2013 12:25 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> A bunch of cleanups for arch/arm/mach-tegra, mostly just deleting
> stale code.
> 
> Stephen Warren (7):
>   ARM: tegra: remove common.c
>   ARM: tegra: delete stale header content
>   ARM: tegra: delete gpio-names.h
>   ARM: tegra: move resume vector define to irammap.h
>   ARM: tegra: remove much of iomap.h
>   ARM: tegra: remove tegra_chip_uid()
>   ARM: tegra: make tegra_init_fuse() __init

I've applied this series, excluding patch 6 which I expect to go through
the crypto tree along with the patch it depends on, to Tegra's
for-3.13/cleanup branch.
