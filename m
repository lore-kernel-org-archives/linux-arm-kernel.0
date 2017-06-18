From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Jun 2017 09:05:09 -0500
Subject: [PATCH] dt-bindings: usb: exynos-usb: Add missing required VDD
 properties
In-Reply-To: <20170613162925.21847-1-krzk@kernel.org>
References: <20170613162925.21847-1-krzk@kernel.org>
Message-ID: <20170618140509.drnbufawhfse6rky@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 06:29:25PM +0200, Krzysztof Kozlowski wrote:
> Since commit bd8ce544ec35 ("usb: dwc3: exynos: Make provision for vdd
> regulators") vdd33-supply and vdd10-supply are required so document them
> in bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/usb/exynos-usb.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Applied.

Rob
