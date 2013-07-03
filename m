From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 3 Jul 2013 14:39:37 +0200
Subject: [PATCH] ARM: tegra: fix VBUS regulator GPIO polarity in DT
In-Reply-To: <1372712825-13757-1-git-send-email-swarren@wwwdotorg.org>
References: <1372712825-13757-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201307031439.38070.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 July 2013, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Commit 4c94c8b "ARM: tegra: update device trees for USB binding rework"
> added regulator definitions for GPIO-controlled USB VBUS. However, none
> of these contained the essential DT property enable-active-high. Add
> this so that the regulator definitions are correct.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> I'm sending this to arm-soc to be taken into v3.11-rc1. However, if it
> won't get in until -rc2, let me know; I'd be tempted not to fix it in
> 3.11 in that case, so I don't have to wait until v3.11-rc2 before
> applying patches that use these new regulators, since they rely on this
> fix going in first.

Applied to fixes branch, thanks!

	Arnd
