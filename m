From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 4 Nov 2018 13:07:04 +0100
Subject: [PATCH 06/11] dt-bindings: spi/spi-pxa2xx: Add spi-slave property
In-Reply-To: <20181010170936.316862-7-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-7-lkundrak@v3.sk>
Message-ID: <20181104120704.GR23864@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-10-10 19:09:31, Lubomir Rintel wrote:
> This is used to indicate that the chip attached to this controller is a SPI
> master.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

Rob, can you apply this?
									Pavel

> ---
>  Documentation/devicetree/bindings/spi/spi-pxa2xx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
> index 0335a9bd2e8a..89b2832283e3 100644
> --- a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
> @@ -11,6 +11,7 @@ Required properties:
>  Optional properties:
>  - cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
>    Documentation/devicetree/bindings/spi/spi-bus.txt
> +- spi-slave: Empty property indicating the SPI controller is used in slave mode.
>  
>  Child nodes represent devices on the SPI bus
>    See ../spi/spi-bus.txt

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181104/d4732db2/attachment.sig>
