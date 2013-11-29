From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Nov 2013 14:08:29 +0100
Subject: [PATCH 05/31] ARM: tegra: update DT files to add DMA properties
In-Reply-To: <1384548866-13141-6-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-6-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131129130828.GR22771@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:54:00PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This patch switches the Tegra DT files to use the standard DMA DT bindings
> rather than custom properties. Note that the legacy properties are not yet
> removed; the drivers must be updated to use the new properties first.
> 
> Cc: treding at nvidia.com
> Cc: pdeschrijver at nvidia.com
> Cc: linux-tegra at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra114.dtsi | 45 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/tegra20.dtsi  | 35 ++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/tegra30.dtsi  | 39 +++++++++++++++++++++++++++++++++++
>  3 files changed, 119 insertions(+)

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/ed2e841b/attachment-0001.sig>
