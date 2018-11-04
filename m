From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 4 Nov 2018 13:32:36 +0100
Subject: [PATCH 10/15] dt-bindings: olpc_battery: Add XO-1.5 battery
In-Reply-To: <20181010172300.317643-11-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-11-lkundrak@v3.sk>
Message-ID: <20181104123236.GC23864@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-10-10 19:22:55, Lubomir Rintel wrote:
> The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> ambient temperature.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

Rob, can you apply?

Thanks,
								Pavel
> ---
>  Documentation/devicetree/bindings/power/supply/olpc_battery.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/olpc_battery.txt b/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
> index c8901b3992d9..8d87d6b35a98 100644
> --- a/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
> @@ -2,4 +2,4 @@ OLPC battery
>  ~~~~~~~~~~~~
>  
>  Required properties:
> -  - compatible : "olpc,xo1-battery"
> +  - compatible : "olpc,xo1-battery" or "olpc,xo1.5-battery"

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181104/c07f98c4/attachment.sig>
