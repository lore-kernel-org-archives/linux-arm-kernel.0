From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Jan 2017 18:15:31 +0000
Subject: [PATCH] ASoC: sunxi: Add bindings for sun8i to SPDIF
In-Reply-To: <20170112173343.9953-1-codekipper@gmail.com>
References: <20170112173343.9953-1-codekipper@gmail.com>
Message-ID: <20170117181531.fdwc5vglpvxpx7su@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2017 at 06:33:43PM +0100, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> The H3 SoC uses the same SPDIF block as found in earlier SoCs, but the
> transmit fifo is at a different address.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt | 1 +
>  1 file changed, 1 insertion(+)

This is fine but it doesn't actually add the compatible string to the
driver which I'd expect.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170117/5c3d2259/attachment-0001.sig>
