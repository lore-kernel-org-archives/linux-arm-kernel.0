From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Sep 2014 01:30:24 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: add missing Tegra options
In-Reply-To: <1411666704-7153-1-git-send-email-swarren@wwwdotorg.org>
References: <1411666704-7153-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201409260130.24870.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 September 2014, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Add all HW-support options from tegra_defconfig that are missing from
> multi_v7_defconfig.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> I validated that this applies and builds OK on top of:
> arm-soc/for-next b161d35992ed ("Merge branches 'next/defconfig', ...")
> next-20140925

Applied to next/defconfig, thanks!

	Arnd
