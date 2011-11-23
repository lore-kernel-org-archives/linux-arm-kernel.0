From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Nov 2011 10:25:49 +0000
Subject: [PATCH 08/17] ASoC: Tegra I2S: Use devm_ APIs and
 module_platform_driver
In-Reply-To: <1322011285-4002-9-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
 <1322011285-4002-9-git-send-email-swarren@nvidia.com>
Message-ID: <20111123102548.GG4332@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 06:21:16PM -0700, Stephen Warren wrote:
> module_platform_drive saves some boiler-plate code.
> 
> The devm_ APIs remove the need to manually clean up allocations,
> thus removing some code.

Applied but again this should be split into two separate patches.
