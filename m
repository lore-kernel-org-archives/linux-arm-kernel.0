From: olof@lixom.net (Olof Johansson)
Date: Sun, 24 Aug 2014 11:21:51 -0700
Subject: [PATCH] ARM: tegra: apalis/colibri t30: fix on-module 5v0 supplies
In-Reply-To: <1408735510-2654-1-git-send-email-swarren@wwwdotorg.org>
References: <1408735510-2654-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140824182151.GA11563@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 22, 2014 at 01:25:10PM -0600, Stephen Warren wrote:
> From: Marcel Ziswiler <marcel@ziswiler.com>
> 
> Working on Gigabit/PCIe support in U-Boot for Apalis T30 I realised
> that the current device tree source includes for our modules only
> happen to work due to referencing the on-carrier 5v0 supply from USB
> which is not at all available on-module. The modules actually contain
> TPS60150 charge pumps to generate the PMIC required 5 volts from the
> one and only 3.3 volt module supply. This patch fixes this.
> 
> (Note: When back-porting this to v3.16 stable releases, simply drop the
> change to tegra30-apalis.dtsi; that file was added in v3.17)
> 
> Cc: <stable@vger.kernel.org> #v3.16+
> Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied, thanks.


-Olof
