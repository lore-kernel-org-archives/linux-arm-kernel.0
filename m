From: robh@kernel.org (Rob Herring)
Date: Thu, 20 Apr 2017 09:18:30 -0500
Subject: [PATCH v3 03/12] dt-bindings: make AXP20X compatible strings one
 per line
In-Reply-To: <20170417115747.7300-4-icenowy@aosc.io>
References: <20170417115747.7300-1-icenowy@aosc.io>
 <20170417115747.7300-4-icenowy@aosc.io>
Message-ID: <20170420141830.63tusju7typolwxa@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 17, 2017 at 07:57:38PM +0800, Icenowy Zheng wrote:
> In the binding documentation of AXP20X mfd, the compatible strings used
> to be listed for three per line, which leads to some mess when trying to
> add AXP803 compatible string (as we have already AXP806 and AXP809
> compatibles, which is after AXP803 in ascending order).
> 
> Make the compatible strings one per line, so that inserting a new
> compatible string will be directly a new line.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> New patch in v3.
> 
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
