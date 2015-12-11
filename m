From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 Dec 2015 12:00:04 +0100
Subject: [linux-sunxi][PATCH 2/2] ARM: dts: sun7i: Add audio codec to
 Itead Ibox
In-Reply-To: <1449599344-15544-2-git-send-email-codekipper@gmail.com>
References: <1449599344-15544-1-git-send-email-codekipper@gmail.com>
 <1449599344-15544-2-git-send-email-codekipper@gmail.com>
Message-ID: <20151211110004.GN27957@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 08, 2015 at 07:29:04PM +0100, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

A commit log would be nice :)

> ---
>  arch/arm/boot/dts/sun7i-a20-itead-ibox.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
> index 90ff677..0950b59 100644
> --- a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
> @@ -70,6 +70,10 @@
>  	status = "okay";
>  };
>  
> +&codec {
> +	status = "okay";
> +};
> +

This can be squashed in the previous patch.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151211/e516a837/attachment.sig>
