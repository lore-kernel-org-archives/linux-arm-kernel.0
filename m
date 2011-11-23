From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Nov 2011 10:25:14 +0000
Subject: [PATCH 07/17] ASoC: Tegra DAS: Use devm_ APIs and
 module_platform_driver
In-Reply-To: <1322011285-4002-8-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
 <1322011285-4002-8-git-send-email-swarren@nvidia.com>
Message-ID: <20111123102514.GF4332@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 06:21:15PM -0700, Stephen Warren wrote:
> module_platform_drive saves some boiler-plate code.
> 
> The devm_ APIs remove the need to manually clean up allocations,
> thus removing some code.

Applied but this is two separate changes and should've been split.
