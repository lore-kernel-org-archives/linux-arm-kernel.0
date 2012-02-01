From: olof@lixom.net (Olof Johansson)
Date: Tue, 31 Jan 2012 23:39:26 -0800
Subject: [PATCH] ARM: tegra: Add pinmux board file for Cardhu
In-Reply-To: <1327511715-27350-1-git-send-email-swarren@nvidia.com>
References: <1327511715-27350-1-git-send-email-swarren@nvidia.com>
Message-ID: <20120201073926.GG7399@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2012 at 10:15:15AM -0700, Stephen Warren wrote:
> For now, this just sets up the pinmux and GPIOs required for the SD
> card slot.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> Tested-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
> This will hopefully be replaced by the pinmux DT binding in the near
> future, but until that happens, Tegra30 pinmux functionality needs to
> be exposed somehow to unblock getting drivers tested on Tegra30.
> 
> This of course depends on my recently posted patches that implement a
> pinctrl subsystem driver for Tegra.
> 
> (Peter said: Boot tested on Cardhu, MMC still doesn't work but that might
> have another rootcause...)

Thanks, applied.


-Olof
