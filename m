From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 13 Jun 2017 16:51:54 +0200
Subject: [PATCH 08/15] ARM: dts: tegra: fix PCI bus dtc warnings
In-Reply-To: <20170322020313.24338-8-robh@kernel.org>
References: <20170322020313.24338-1-robh@kernel.org>
 <20170322020313.24338-8-robh@kernel.org>
Message-ID: <20170613145154.GB20577@ulmo.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 09:03:06PM -0500, Rob Herring wrote:
> dtc recently added PCI bus checks. Fix these warnings.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: linux-tegra at vger.kernel.org
> ---
> Sub-arch maintainers, please apply to your trees unless arm-soc wants 
> to take the whole lot.
> 
>  arch/arm/boot/dts/tegra124-apalis-eval.dts | 2 +-
>  arch/arm/boot/dts/tegra124-apalis.dtsi     | 2 +-
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts  | 2 +-
>  arch/arm/boot/dts/tegra124.dtsi            | 4 +++-
>  arch/arm/boot/dts/tegra20-harmony.dts      | 2 +-
>  arch/arm/boot/dts/tegra20-tamonten.dtsi    | 2 +-
>  arch/arm/boot/dts/tegra20-tec.dts          | 2 +-
>  arch/arm/boot/dts/tegra20-trimslice.dts    | 2 +-
>  arch/arm/boot/dts/tegra20.dtsi             | 4 +++-
>  arch/arm/boot/dts/tegra30-apalis-eval.dts  | 2 +-
>  arch/arm/boot/dts/tegra30-apalis.dtsi      | 2 +-
>  arch/arm/boot/dts/tegra30-beaver.dts       | 2 +-
>  arch/arm/boot/dts/tegra30-cardhu.dtsi      | 2 +-
>  arch/arm/boot/dts/tegra30.dtsi             | 5 ++++-
>  14 files changed, 21 insertions(+), 14 deletions(-)

Doesn't look like ARM SoC took the lot, so I've applied this to the
Tegra tree for v4.13.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170613/7c4a2975/attachment.sig>
