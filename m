From: robh@kernel.org (Rob Herring)
Date: Thu, 13 Apr 2017 14:57:20 -0500
Subject: [PATCH v2 06/11] dt-bindings: add AXP803's regulator info
In-Reply-To: <20170407183441.58750-7-icenowy@aosc.io>
References: <20170407183441.58750-1-icenowy@aosc.io>
 <20170407183441.58750-7-icenowy@aosc.io>
Message-ID: <20170413195720.rgz66jbk6hwtb2mt@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 08, 2017 at 02:34:36AM +0800, Icenowy Zheng wrote:
> AXP803 have the most regulators in currently supported AXP PMICs.
> 
> Add info for the regulators in the dt-bindings document.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v2:
> - Place AXP803 regulators before AXP806/809 ones.
> 
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 27 ++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
