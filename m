From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Nov 2011 11:08:52 +0000
Subject: [PATCH 12/17] ASoC: Tegra+WM8903 machine: Use devm_ APIs and
 module_platform_driver
In-Reply-To: <1322011285-4002-13-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
 <1322011285-4002-13-git-send-email-swarren@nvidia.com>
Message-ID: <20111123110852.GE21073@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 06:21:20PM -0700, Stephen Warren wrote:
> module_platform_drive saves some boiler-plate code.
> 
> The devm_ APIs remove the need to manually clean up allocations,
> thus removing some code.

Applied, thanks.  Again, should be two changes.
