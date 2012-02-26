From: olof@lixom.net (Olof Johansson)
Date: Sun, 26 Feb 2012 13:51:41 -0800
Subject: [PATCH V2 1/2] ARM: tegra: Add pinmux board file for Cardhu
In-Reply-To: <1328138997-25665-1-git-send-email-swarren@nvidia.com>
References: <1328138997-25665-1-git-send-email-swarren@nvidia.com>
Message-ID: <20120226215141.GA11189@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2012 at 04:29:56PM -0700, Stephen Warren wrote:
> For now, this just sets up the pinmux and GPIOs required for the SD
> card slot.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> v2:
> * Set PULL_UP for CMD and DATA pins on SD interface
> * Add power GPIO for SDMMC1
> * Add pinmux configuration for SDMMC4
> 
> This will hopefully be replaced by the pinmux DT binding in the near
> future, but until that happens, Tegra30 pinmux functionality needs to
> be exposed somehow to unblock getting drivers tested on Tegra30.

Thanks, applied to for-3.4/boards.


-Olof
