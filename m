From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jul 2012 20:09:40 +0000
Subject: [PATCH 1/2] ARM: dt: tegra trimslice: enable USB2 port
In-Reply-To: <1343246564-21527-1-git-send-email-swarren@wwwdotorg.org>
References: <1343246564-21527-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201207252009.41206.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 July 2012, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This was accidentally disabled by commit 2a5fdc9 "ARM: dt: tegra:
> invert status=disable vs status=okay".
> 
> Cc: <stable@vger.kernel.org> # v3.5 (file is named tegra-trimslice.dts there)
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied both, thanks!

	Arnd
