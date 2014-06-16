From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Jun 2014 13:28:29 -0600
Subject: [PATCH] ARM: tegra: powergate: Use PMC register accessors
In-Reply-To: <1402487285-5626-1-git-send-email-thierry.reding@gmail.com>
References: <1402487285-5626-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <539F455D.80204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2014 05:48 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Instead of I/O remapping the registers itself, make the powergate API
> use the PMC register accessors from the PMC implementation.
> 
> This is necessary to allow these drivers to be moved out of arch/arm,
> which in turn will be needed to share code with 64-bit Tegra SoCs.

Applied to Tegra's for-3.17/soc branch.
