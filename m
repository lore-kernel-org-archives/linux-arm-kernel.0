From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 3 Nov 2018 20:04:47 +0100
Subject: [PATCH] DT: marvell,mmp2: give gpio node a name
In-Reply-To: <20180917112303.8701-1-lkundrak@v3.sk>
References: <20180917112303.8701-1-lkundrak@v3.sk>
Message-ID: <20181103190447.GB31179@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2018-09-17 13:23:03, Lubomir Rintel wrote:
> This will be useful for boards that actually use GPIO pins.
> 
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

>  arch/arm/boot/dts/mmp2.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
> index 766bbb8495b6..f8867364e5a1 100644
> --- a/arch/arm/boot/dts/mmp2.dtsi
> +++ b/arch/arm/boot/dts/mmp2.dtsi
> @@ -168,7 +168,7 @@
>  				status = "disabled";
>  			};
>  
> -			gpio at d4019000 {
> +			gpio: gpio at d4019000 {
>  				compatible = "marvell,mmp2-gpio";
>  				#address-cells = <1>;
>  				#size-cells = <1>;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181103/21302492/attachment.sig>
