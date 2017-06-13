From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 13 Jun 2017 15:36:44 +0200
Subject: [PATCH 2/2] ASoC: tegra: remove Whistler machine driver
In-Reply-To: <20170413185559.1939-2-swarren@wwwdotorg.org>
References: <20170413185559.1939-1-swarren@wwwdotorg.org>
 <20170413185559.1939-2-swarren@wwwdotorg.org>
Message-ID: <20170613133644.GF16758@ulmo.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 12:55:59PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The previous patch removed Whistler board support. There's no need to
> keep around a Whistler-specific ASoC machine driver.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  .../bindings/sound/nvidia,tegra-audio-wm8753.txt   |  40 ----
>  sound/soc/tegra/Kconfig                            |  10 -
>  sound/soc/tegra/Makefile                           |   4 +-
>  sound/soc/tegra/tegra_wm8753.c                     | 219 ---------------------
>  4 files changed, 1 insertion(+), 272 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt
>  delete mode 100644 sound/soc/tegra/tegra_wm8753.c

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170613/d8b63d2c/attachment.sig>
