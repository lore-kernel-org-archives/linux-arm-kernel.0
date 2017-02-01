From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Feb 2017 11:47:26 -0600
Subject: [PATCH] Documentation: devicetree: meson-ir: "linux, rc-map-name"
 is supported
In-Reply-To: <20170131212112.5582-1-martin.blumenstingl@googlemail.com>
References: <20170131212112.5582-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170201174726.2vyvxpnie7qclrvk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 10:21:12PM +0100, Martin Blumenstingl wrote:
> The driver already parses the "linux,rc-map-name" property. Add this
> information to the documentation so .dts maintainers don't have to look
> it up in the source-code.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  Documentation/devicetree/bindings/media/meson-ir.txt | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
