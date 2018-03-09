From: robh@kernel.org (Rob Herring)
Date: Fri, 9 Mar 2018 17:02:25 -0600
Subject: [PATCH v2] dt-bindings: exynos: Document #sound-dai-cells
 property of the HDMI node
In-Reply-To: <20180309154016.15562-1-s.nawrocki@samsung.com>
References: <CGME20180309154029epcas1p280472548d1aa86daafceb405b10f1589@epcas1p2.samsung.com>
 <20180309154016.15562-1-s.nawrocki@samsung.com>
Message-ID: <20180309230225.i2ytunejt2sotsrc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2018 at 04:40:16PM +0100, Sylwester Nawrocki wrote:
> The #sound-dai-cells DT property is required to describe link between
> the HDMI IP block and the SoC's audio subsystem.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v2:
>  - the property has been moved to "Required properties" paragraph,
>    I didn't add Rob's Reviewed-by due to this change
> ---
>  Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
