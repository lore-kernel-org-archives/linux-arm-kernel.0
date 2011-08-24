From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Aug 2011 10:33:33 +0100
Subject: [PATCH] ASoC: Tegra: wm8903 machine driver: Drop Ventana support
In-Reply-To: <1314119788-23000-1-git-send-email-swarren@nvidia.com>
References: <1314119788-23000-1-git-send-email-swarren@nvidia.com>
Message-ID: <20110824093332.GD15687@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 11:16:28AM -0600, Stephen Warren wrote:
> Board file support for Ventana is not yet mainlined, and probably won't
> ever be given the move to Device-Tree. Consequently, the Ventana entry
> is being removed from arch/arm/tools/mach-types in the next merge window,
> since it was registered over a year ago.

Applied, thanks.
