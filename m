From: robh@kernel.org (Rob Herring)
Date: Tue, 12 Sep 2017 16:49:23 -0500
Subject: [PATCH v2 4/6] dt-bindings: host1x: Add Tegra186 information
In-Reply-To: <20170905084306.19318-5-mperttunen@nvidia.com>
References: <20170905084306.19318-1-mperttunen@nvidia.com>
 <20170905084306.19318-5-mperttunen@nvidia.com>
Message-ID: <20170912214923.aqyme6ftykahjuw4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 05, 2017 at 11:43:04AM +0300, Mikko Perttunen wrote:
> Add the Tegra186-specific hypervisor-related register range
> properties.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> v2:
> - Dropped incorrect note about cells properties.
> 
>  .../devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt       | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Rob Herring <robh@kernel.org> 
