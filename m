From: robh@kernel.org (Rob Herring)
Date: Thu, 1 Mar 2018 16:41:51 -0600
Subject: [PATCH v1 1/5] dt-bindings: soc: update MT2712 power dt-bindings
In-Reply-To: <20180222054851.26096-3-weiyi.lu@mediatek.com>
References: <20180222054851.26096-1-weiyi.lu@mediatek.com>
 <20180222054851.26096-3-weiyi.lu@mediatek.com>
Message-ID: <20180301224151.bl3syre32pqfcsls@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 01:48:47PM +0800, Weiyi Lu wrote:
> Add new power domains(MFG_SC1/MFG_SC2/MFG_SC3)
> for MT2712 according to ECO design change.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  include/dt-bindings/power/mt2712-power.h | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
