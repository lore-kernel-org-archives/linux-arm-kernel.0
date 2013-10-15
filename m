From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 15 Oct 2013 11:54:26 +0200
Subject: [PATCH] ARM: tegra: add GPIO controller to tegra124.dtsi
In-Reply-To: <1381787167-3011-1-git-send-email-swarren@wwwdotorg.org>
References: <1381787167-3011-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131015095426.GL7856@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 03:46:07PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The Tegra124 GPIO controller is identical to Tegra30, so copy the
> DT node from tegra30.dtsi to tegra124.dtsi.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra124.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131015/1b43f422/attachment.sig>
