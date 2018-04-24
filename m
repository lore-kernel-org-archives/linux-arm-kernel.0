From: robh@kernel.org (Rob Herring)
Date: Tue, 24 Apr 2018 09:37:59 -0500
Subject: [PATCH v1 1/4] dt-bindings: gpu: mali-utgard: add
 mediatek,mt7623-mali compatible
In-Reply-To: <831e85ebdfdaba3c7b05ac8407a1584c20ba4a86.1524044917.git.sean.wang@mediatek.com>
References: <cover.1524044917.git.sean.wang@mediatek.com>
 <831e85ebdfdaba3c7b05ac8407a1584c20ba4a86.1524044917.git.sean.wang@mediatek.com>
Message-ID: <20180424143759.tyveqnfxtkmanosn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2018 at 06:24:53PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> The MediaTek MT7623 SoC contains a Mali-450, so add a compatible for it
> and define its own vendor-specific properties.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
