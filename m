From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Mar 2018 17:22:56 -0500
Subject: [PATCH 1/7] dt-bindings: add compatible string for the A64 DE2 CCU
In-Reply-To: <20180316175354.21437-2-icenowy@aosc.io>
References: <20180316175354.21437-1-icenowy@aosc.io>
 <20180316175354.21437-2-icenowy@aosc.io>
Message-ID: <20180326222256.fhdcodfx7ff4zyij@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 17, 2018 at 01:53:48AM +0800, Icenowy Zheng wrote:
> The Allwinner A64 SoC has a DE2 CCU like the one in the DE2 of Allwinner
> H5 SoC.
> 
> Add a compatible string for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/clock/sun8i-de2.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
