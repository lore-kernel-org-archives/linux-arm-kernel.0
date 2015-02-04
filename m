From: robherring2@gmail.com (Rob Herring)
Date: Wed, 4 Feb 2015 09:12:26 -0600
Subject: [PATCH V9 10/14] Documentation: devicetree: Add vendor prefix for
 parade
In-Reply-To: <1421771935-31618-11-git-send-email-ajaykumar.rs@samsung.com>
References: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
 <1421771935-31618-11-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <CAL_Jsq+1uE6V5MvoBbvY=9WgCCoQR4WoZ64GNA-HtXi=xU04PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 10:38 AM, Ajay Kumar <ajaykumar.rs@samsung.com> wrote:
> ps8622 eDP-LVDS converter bridge chip is from parade technologies
>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> Acked-by: Inki Dae <inki.dae@samsung.com>
> Tested-by: Rahul Sharma <rahul.sharma@samsung.com>
> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Tested-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> Tested-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 4df1d78..eca48be 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -125,6 +125,7 @@ nxp NXP Semiconductors
>  onnn   ON Semiconductor Corp.
>  opencores      OpenCores.org
>  panasonic      Panasonic Corporation
> +parade Parade Technologies Inc.
>  pericom        Pericom Technology Inc.
>  phytec PHYTEC Messtechnik GmbH
>  picochip       Picochip Ltd
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
