From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Sep 2011 19:43:29 +0200
Subject: [PATCH REPOST 1/2] arm/dt: Tegra: Update SDHCI nodes to match
	bindings
In-Reply-To: <1316537186-26753-1-git-send-email-swarren@nvidia.com>
References: <1316537186-26753-1-git-send-email-swarren@nvidia.com>
Message-ID: <201109201943.29510.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 September 2011, Stephen Warren wrote:
> The bindings were recently updated to have separate properties for each
> type of GPIO. Update the Device Tree source to match that.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> Acked-by: Olof Johansson <olof@lixom.net>
> ---
> I'd previously sent these to Grant assuming they'd go in his dt/next branch,
> but perhaps these should go in through Arnd's arm-soc next/dt branch?
> 

Which tree has the update that changed the bindings? I think it should
go into the same one.

If it's already upstream, I can take it into the fixes branch.

	Arnd
