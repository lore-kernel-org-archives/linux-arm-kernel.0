From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 26 Jul 2016 10:58:58 +0100
Subject: [PATCH 2/3] dt-bindings: allow child nodes inside the Tegra BPMP
In-Reply-To: <20160719191442.15439-2-swarren@wwwdotorg.org>
References: <20160719191442.15439-1-swarren@wwwdotorg.org>
 <20160719191442.15439-2-swarren@wwwdotorg.org>
Message-ID: <dde2142c-678e-21c7-f7eb-1c61c1639be5@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 19/07/16 20:14, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The BPMP implements some services which must be represented by separate
> nodes. For example, it can provide access to certain I2C controllers, and
> the I2C bindings represent each I2C controller as a device tree node.
> Update the binding to describe how the BPMP supports this.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  .../bindings/firmware/nvidia,tegra186-bpmp.txt     | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic
