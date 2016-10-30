From: robh@kernel.org (Rob Herring)
Date: Sun, 30 Oct 2016 15:41:24 -0500
Subject: [PATCH] dt-bindings: video: exynos7-decon: Remove obsolete
 samsung,power-domain property
In-Reply-To: <1477058754-13866-1-git-send-email-krzk@kernel.org>
References: <1477058754-13866-1-git-send-email-krzk@kernel.org>
Message-ID: <20161030204124.wwvv2qfshj7lvggx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 05:05:54PM +0300, Krzysztof Kozlowski wrote:
> The samsung,power-domain property is obsolete since commit 0da658704136
> ("ARM: dts: convert to generic power domain bindings for exynos DT").
> Replace it with generic one.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/exynos/exynos7-decon.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You didn't send this To me, so I assume someone else is applying it.

Acked-by: Rob Herring <robh@kernel.org>
