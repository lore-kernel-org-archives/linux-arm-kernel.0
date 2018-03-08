From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 20:41:00 -0600
Subject: [PATCH] dt-bindings: exynos: Document #sound-dai-cells property
 of the HDMI node
In-Reply-To: <20180307171111.14551-1-s.nawrocki@samsung.com>
References: <CGME20180307171131epcas1p4687ef394d1a0a6d0eb2de2691c977c3f@epcas1p4.samsung.com>
 <20180307171111.14551-1-s.nawrocki@samsung.com>
Message-ID: <20180308024100.lpfohlwz6dtghpvy@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2018 at 06:11:11PM +0100, Sylwester Nawrocki wrote:
> The #sound-dai-cells DT property is required to describe link between
> the HDMI IP block and the SoC's audio subsystem.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
