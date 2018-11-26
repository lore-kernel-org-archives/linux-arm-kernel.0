From: broonie@kernel.org (Mark Brown)
Date: Mon, 26 Nov 2018 14:53:42 +0000
Subject: [PATCH v8 1/7] ASoC: dt-bindings: add regulator property to
 simple amplifier
In-Reply-To: <20181121051752.18387-2-anarsoul@gmail.com>
References: <20181121051752.18387-1-anarsoul@gmail.com>
 <20181121051752.18387-2-anarsoul@gmail.com>
Message-ID: <20181126145342.GE9715@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 09:17:46PM -0800, Vasily Khoruzhick wrote:

> +Optional properties:
> +- VCC-supply   : power supply for the device, as covered
> +                 in Documentation/devicetree/bindings/regulator/regulator.txt
> +

As ever supplies shouldn't be marked as optional unless they can be
missing even though they can safely be omitted on Linux.  This one's a
bit odd in that the name is going to depend on which amp is connected
but still it's probably best that we do that for consistency.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181126/17bc6e82/attachment.sig>
