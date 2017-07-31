From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 31 Jul 2017 12:23:09 +0200
Subject: [PATCH 1/3] sound: ASoC: tegra: Remove SoC-specific Kconfig
 depends and selects
In-Reply-To: <20170730112220.15525-1-contact@paulk.fr>
References: <20170730112220.15525-1-contact@paulk.fr>
Message-ID: <20170731102309.GE26667@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 30, 2017 at 01:22:18PM +0200, Paul Kocialkowski wrote:
> This removes the SoC-specific dependencies on the platform drivers,
> as well as SoC-specific selections of platform drivers for the
> machine drivers. The rationale behind this change is that the
> dependencies are not actual build dependencies but run-time ones.
> 
> The previously listed SoCs were also incomplete: for instance, tegra124
> uses the tegra30 platform drivers, which could not be built without
> ARCH_TEGRA_3x_SOC set.
> 
> Descriptions of the tristates are also added to allow these options
> to be set via defconfig/menuconfig.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  sound/soc/tegra/Kconfig | 42 ++++++++++++++----------------------------
>  1 file changed, 14 insertions(+), 28 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170731/d5764aeb/attachment.sig>
