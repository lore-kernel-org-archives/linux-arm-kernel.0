From: robh@kernel.org (Rob Herring)
Date: Tue, 30 May 2017 17:51:36 -0500
Subject: [PATCH v2 2/2] dt-bindings: phy: meson8b-usb2-phy: add support
 for the Meson8 SoCs
In-Reply-To: <20170520141250.27388-3-martin.blumenstingl@googlemail.com>
References: <20170506173625.19501-1-martin.blumenstingl@googlemail.com>
 <20170520141250.27388-1-martin.blumenstingl@googlemail.com>
 <20170520141250.27388-3-martin.blumenstingl@googlemail.com>
Message-ID: <20170530225136.pgczqrzsl6cvilyp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 20, 2017 at 04:12:50PM +0200, Martin Blumenstingl wrote:
> Meson8 uses the same USB PHY as found on the Meson8b and GXBB SoCs. This
> adds a new compatible string to indicate that this binding also supports
> the Meson8 SoCs.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
