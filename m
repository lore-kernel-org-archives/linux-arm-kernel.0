From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Nov 2011 10:24:24 +0000
Subject: [PATCH 05/17] ASoC: Tegra: Move DAS configuration into machine
 drivers
In-Reply-To: <1322011285-4002-6-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
 <1322011285-4002-6-git-send-email-swarren@nvidia.com>
Message-ID: <20111123102424.GD4332@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 06:21:13PM -0700, Stephen Warren wrote:
> This removes potentially machine-specific routing knowledge from the
> I2S driverinto the machine drivers, which is better equipped to know
> what the appropriate routing configuration is.

Applied, thanks.
