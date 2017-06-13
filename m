From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 13 Jun 2017 15:36:33 +0200
Subject: [PATCH 1/2] ARM: tegra: remove Whistler support
In-Reply-To: <20170413185559.1939-1-swarren@wwwdotorg.org>
References: <20170413185559.1939-1-swarren@wwwdotorg.org>
Message-ID: <20170613133633.GE16758@ulmo.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 12:55:58PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Whistler is an ancient Tegra 2 reference board. I may have been the only
> person who ever used it with upstream software, and I've just recycled
> the board hardware. Hence, it makes sense to remove support from software.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  Documentation/devicetree/bindings/arm/tegra.txt |   1 -
>  arch/arm/boot/dts/Makefile                      |   3 +-
>  arch/arm/boot/dts/tegra20-whistler.dts          | 636 ------------------------
>  3 files changed, 1 insertion(+), 639 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/tegra20-whistler.dts

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170613/af140a24/attachment.sig>
