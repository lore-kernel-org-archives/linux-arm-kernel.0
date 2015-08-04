From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Aug 2015 18:42:26 +0100
Subject: [PATCH v4 1/3] dt-binding: spi: Mediatek: Document devicetree
 bindings for spi bus
In-Reply-To: <1438167874-1305-2-git-send-email-leilk.liu@mediatek.com>
References: <1438167874-1305-1-git-send-email-leilk.liu@mediatek.com>
 <1438167874-1305-2-git-send-email-leilk.liu@mediatek.com>
Message-ID: <20150804174226.GE20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 07:04:32PM +0800, Leilk Liu wrote:
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>

Please use subject lines reflecting the style for the subsystem so
people can spot if patches are relevant to them.

> +- clocks: phandles to input clocks.
> +
> +- clock-names: tuple listing input clock names.
> +	Required elements: "main"

...and there are no optional values?

> +- pad-select: should specify spi pad used, only required for MT8173.
> +        This value should be 0~3.

What do the values 0-3 mean?  I guess it's the value for some register
or other part of the device, the binding should say so people can go and
check the datasheet, schematic or whatever to figure out what to set.

This property should be optional, not required
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150804/2584c731/attachment.sig>
