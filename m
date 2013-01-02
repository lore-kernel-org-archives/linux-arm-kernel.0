From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 02 Jan 2013 11:21:11 -0700
Subject: [PATCH V4 3/3] ARM: tegra: move timer.c to drivers/clocksource/
In-Reply-To: <1353453142-4973-3-git-send-email-swarren@wwwdotorg.org>
References: <1353453142-4973-1-git-send-email-swarren@wwwdotorg.org>
 <1353453142-4973-3-git-send-email-swarren@wwwdotorg.org>
Message-ID: <50E47A97.2000401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2012 04:12 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Move arch/arm/mach-tegra/timer.c to drivers/clocksource/tegra20_timer.c
> so that the code is co-located with other clocksource drivers, and to
> reduce the size of the mach-tegra directory.

I have applied this to Tegra's for-3.9/cleanup branch.
