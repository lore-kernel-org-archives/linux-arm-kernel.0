From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Nov 2011 10:23:19 +0000
Subject: [PATCH 07/17] ASoC: Tegra DAS: Use devm_ APIs and
 module_platform_driver
In-Reply-To: <20111123065808.GB5255@avionic-0098.adnet.avionic-design.de>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
 <1322011285-4002-8-git-send-email-swarren@nvidia.com>
 <20111123065808.GB5255@avionic-0098.adnet.avionic-design.de>
Message-ID: <20111123102319.GC4332@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 07:58:08AM +0100, Thierry Reding wrote:
> * Stephen Warren wrote:

> > -	platform_set_drvdata(pdev, NULL);
> > -

> Setting the driver data to NULL may still be a good idea.

It's always been a waste of time.
