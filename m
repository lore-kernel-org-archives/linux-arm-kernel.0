From: robh@kernel.org (Rob Herring)
Date: Thu, 11 Jan 2018 15:46:56 -0600
Subject: [PATCH 4/6] dt-bindings: tegra: Add documentation for
 nvidia,tegra194-pmc
In-Reply-To: <1515387278-29777-5-git-send-email-mperttunen@nvidia.com>
References: <1515387278-29777-1-git-send-email-mperttunen@nvidia.com>
 <1515387278-29777-5-git-send-email-mperttunen@nvidia.com>
Message-ID: <20180111214656.r25lyso42p62zb5b@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 06:54:36AM +0200, Mikko Perttunen wrote:
> The Tegra194 power management controller has one additional register
> aperture to be specified in the device tree node.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
