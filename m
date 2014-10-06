From: robherring2@gmail.com (Rob Herring)
Date: Mon, 6 Oct 2014 10:07:08 -0500
Subject: [PATCH v2 4/7] of: add vendor prefix for Tronsmart
In-Reply-To: <1412546359-15062-5-git-send-email-b.galvani@gmail.com>
References: <1412546359-15062-1-git-send-email-b.galvani@gmail.com>
 <1412546359-15062-5-git-send-email-b.galvani@gmail.com>
Message-ID: <CAL_JsqJS82SzUsZKDom-cNcnWDurtEaJQRDnPnMQiO8u57=Gwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 5, 2014 at 4:59 PM, Beniamino Galvani <b.galvani@gmail.com> wrote:
> This adds Tronsmart to the list of device tree vendor prefixes.
>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index c681434..92a1798 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -141,6 +141,7 @@ tlm Trusted Logic Mobility
>  toradex        Toradex AG
>  toshiba        Toshiba Corporation
>  toumaz Toumaz
> +tronsmart      Tronsmart
>  usi    Universal Scientifc Industrial Co., Ltd.
>  v3     V3 Semiconductor
>  variscite      Variscite Ltd.
> --
> 1.9.1
>
