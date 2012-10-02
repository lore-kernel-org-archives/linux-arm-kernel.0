From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 2 Oct 2012 21:33:16 +0200
Subject: [PATCH] ARM: tegra: update *.dts for regulator-compatible
 deprecation
In-Reply-To: <1349204824-21758-1-git-send-email-swarren@wwwdotorg.org>
References: <1349204824-21758-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20121002193315.GA30966@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2012 at 01:07:04PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Commit 13511de "regulator: deprecate regulator-compatible DT property"
> now allows for simpler content within the regulators node within a PMIC.
> Modify all the Tegra device tree files to take advantage of this.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra20-harmony.dts   |   63 ++++------------
>  arch/arm/boot/dts/tegra20-paz00.dts     |   59 ++++------------
>  arch/arm/boot/dts/tegra20-seaboard.dts  |   59 ++++------------
>  arch/arm/boot/dts/tegra20-tamonten.dtsi |   63 ++++------------
>  arch/arm/boot/dts/tegra20-ventana.dts   |   59 ++++------------
>  arch/arm/boot/dts/tegra20-whistler.dts  |  119 ++++++++-----------------------
>  arch/arm/boot/dts/tegra30-cardhu.dtsi   |   47 +++---------
>  7 files changed, 112 insertions(+), 357 deletions(-)

Funny how this has come full circle.

Acked-by: Thierry Reding <thierry.reding@avionic-design.de>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121002/698128c5/attachment-0001.sig>
