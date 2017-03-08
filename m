From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 8 Mar 2017 13:52:14 +0100
Subject: [PATCH v2] soc/tegra: Implement Tegra186 PMC support
In-Reply-To: <20170223171157.13860-1-thierry.reding@gmail.com>
References: <20170223171157.13860-1-thierry.reding@gmail.com>
Message-ID: <20170308125214.GE29118@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2017 at 06:11:57PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The power management controller on Tegra186 has changed in backwards-
> incompatible ways with respect to earlier generations. This implements a
> new driver that supports inversion of the PMU interrupt as well as the
> "recovery", "bootloader" and "forced-recovery" reboot commands.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - add Kconfig symbol for old and Tegra186 drivers, build conditionally
> 
>  .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |  34 ++++
>  drivers/soc/tegra/Kconfig                          |  13 ++
>  drivers/soc/tegra/Makefile                         |   3 +-
>  drivers/soc/tegra/pmc-tegra186.c                   | 185 +++++++++++++++++++++
>  4 files changed, 234 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
>  create mode 100644 drivers/soc/tegra/pmc-tegra186.c

Applied to for-4.12/soc.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170308/eaffadfb/attachment.sig>
