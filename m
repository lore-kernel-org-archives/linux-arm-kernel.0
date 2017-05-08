From: robh@kernel.org (Rob Herring)
Date: Mon, 8 May 2017 11:44:36 -0500
Subject: [PATCH v2 07/10] dt-bindings: add compatible string for
 Allwinner R40 CCU
In-Reply-To: <20170504135006.16483-8-icenowy@aosc.io>
References: <20170504135006.16483-1-icenowy@aosc.io>
 <20170504135006.16483-8-icenowy@aosc.io>
Message-ID: <20170508164436.vlnrvv6qcu2f74sa@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 04, 2017 at 09:50:03PM +0800, Icenowy Zheng wrote:
> Allwinner R40 has a clock controlling unit like the ones on other
> Allwinner SoCs after sun6i, and can also use a CCU-based driver.
> 
> Add a compatible string for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
