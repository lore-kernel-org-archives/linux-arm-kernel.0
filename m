From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Aug 2016 20:30:09 +0200
Subject: [PATCH 4/8] ARM: dts: sun8i: Add touchscreen node for
 sun8i-a23-gt90h
In-Reply-To: <1470685398-14568-4-git-send-email-hdegoede@redhat.com>
References: <1470685398-14568-1-git-send-email-hdegoede@redhat.com>
 <1470685398-14568-4-git-send-email-hdegoede@redhat.com>
Message-ID: <20160822183009.GX7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 08, 2016 at 09:43:14PM +0200, Hans de Goede wrote:
> The gt90h tablet has a gsl3675 touchscreen, add a dt node describing it.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
> index f27ebbb..da55b5a 100644
> --- a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
> +++ b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
> @@ -53,6 +53,14 @@
>  	status = "okay";
>  };
>  
> +&gsl1680 {
> +	compatible = "silead,gsl3675";
> +	touchscreen-fw-name = "silead/gsl3675-gt90h.fw";

That's not documented anywhere, and looks really suspicious.

Rob, is that even allowed?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/985c1496/attachment.sig>
