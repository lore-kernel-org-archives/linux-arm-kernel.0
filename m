From: robh@kernel.org (Rob Herring)
Date: Mon, 8 May 2017 11:44:14 -0500
Subject: [PATCH v2 05/10] dt-bindings: add compatible string for
 Allwinner R40 pinctrl
In-Reply-To: <20170504135006.16483-6-icenowy@aosc.io>
References: <20170504135006.16483-1-icenowy@aosc.io>
 <20170504135006.16483-6-icenowy@aosc.io>
Message-ID: <20170508164414.qu3v2s7ti6czwwvw@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 04, 2017 at 09:50:01PM +0800, Icenowy Zheng wrote:
> Allwinner R40 has a pin controller like the ones in older Allwinner SoCs
> (especially A20), and can use modified version of the A10/A20 pinctrl
> driver.
> 
> Add a compatible string for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
