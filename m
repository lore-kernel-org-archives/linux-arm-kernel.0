From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 4 Dec 2013 09:41:59 +0100
Subject: [PATCH V2] ARM: tegra: add MMC controllers to Tegra124 DT
In-Reply-To: <1386095199-24336-1-git-send-email-swarren@wwwdotorg.org>
References: <1386095199-24336-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131204084158.GE19943@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 11:26:39AM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Tegra124 has 4 MMC controllers just like previous versions of the SoC.
> Note that there are some non-backwards-compatible HW differences, and
> hence a new DT compatible value must be used to describe the HW.
> 
> Also enable the relevant controllers in the Venice2 board DT.
> 
> power-gpios property suggested by Thierry Reding.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> v2: Add power-gpios to SD card node, suggested by Thierry.
> ---
>  arch/arm/boot/dts/tegra124-venice2.dts | 12 ++++++++++
>  arch/arm/boot/dts/tegra124.dtsi        | 40 ++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)

Reviewed-by: Thierry Reding <treding@nvidia.com>
Tested-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/82a8a157/attachment.sig>
