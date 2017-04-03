From: robh@kernel.org (Rob Herring)
Date: Mon, 3 Apr 2017 10:55:58 -0500
Subject: [PATCH v2] dt-bindings: Add documentation for GP10B GPU
In-Reply-To: <20170330092644.11890-1-acourbot@nvidia.com>
References: <20170330091831.18322-2-acourbot@nvidia.com>
 <20170330092644.11890-1-acourbot@nvidia.com>
Message-ID: <20170403155558.sd44ajcdppcshceo@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 06:26:44PM +0900, Alexandre Courbot wrote:
> GP10B's definition is mostly similar to GK20A's and GM20B's. The only
> noticeable difference is the use of power domains instead of a regulator
> for power supply.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> Changes since v1:
> - It's much better when it compiles.
> 
>  .../devicetree/bindings/gpu/nvidia,gk20a.txt       | 25 +++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org> 
