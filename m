From: robh@kernel.org (Rob Herring)
Date: Tue, 16 Aug 2016 09:25:40 -0500
Subject: [PATCH 1/3] net: dt-bindings: Document the new Meson8b and GXBB
 DWMAC bindings
In-Reply-To: <20160815164100.27766-2-martin.blumenstingl@googlemail.com>
References: <20160625165013.15917-1-martin.blumenstingl@googlemail.com>
 <20160815164100.27766-1-martin.blumenstingl@googlemail.com>
 <20160815164100.27766-2-martin.blumenstingl@googlemail.com>
Message-ID: <20160816142540.GA1332@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2016 at 06:40:58PM +0200, Martin Blumenstingl wrote:
> This patch adds the documentation for the DWMAC ethernet controller
> found in Amlogic Meson 8b (S805) and GXBB (S905) SoCs.
> The main difference between the Meson6 glue is that different registers
> (with different layout) are used.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/net/meson-dwmac.txt        | 43 ++++++++++++++++++----
>  1 file changed, 35 insertions(+), 8 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
