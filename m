From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jul 2012 19:27:50 +0000
Subject: [PATCH] ARM: tegra: harmony: add regulator supply name and its
 input supply
In-Reply-To: <1343147783-24948-1-git-send-email-swarren@wwwdotorg.org>
References: <1343147783-24948-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201207241927.50579.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 July 2012, Stephen Warren wrote:
> From: Laxman Dewangan <ldewangan@nvidia.com>
> 
> Name the regulator as per board schematics and adds its
> supply name info in regulator data.
> Add the always on fixed regulator to refer the battery supply.
> 
> Use this fixed regulator for input supply of some of PMIC
> regulator
> 
> This patch was originally part of a 2-patch series. Patch 2 got applied
> to the regulator tree as 7c7fac3 "regulator: tps6586x: add support for
> input supply" without this patch. This broke regulator support on
> Harmony.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> [swarren: added dependency info to commit description]
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied to fixes branch.

thanks,

	Arnd
