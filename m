From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Mar 2013 20:30:53 +0000
Subject: [PATCH] ARM: tegra: fix register address of slink controller
In-Reply-To: <1363977306-7548-1-git-send-email-swarren@wwwdotorg.org>
References: <1363977306-7548-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201303222030.53942.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 March 2013, Stephen Warren wrote:
> From: Laxman Dewangan <ldewangan@nvidia.com>
> 
> Fix typo on register address of slink3 controller where register
> address is wrongly set as 0x7000d480 but it is 0x7000d800.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Arnd, Olof, this is a fix for v3.9.

Applied to fixes branch, thanks!

	Arnd
