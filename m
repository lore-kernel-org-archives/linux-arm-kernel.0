From: robh@kernel.org (Rob Herring)
Date: Thu, 8 Oct 2015 08:45:00 -0500
Subject: [PATCH v2 1/4] of: documentation: Add vendor prefix for Tronfy
In-Reply-To: <1444249865-6897-2-git-send-email-carlo@caione.org>
References: <1444249865-6897-1-git-send-email-carlo@caione.org>
 <1444249865-6897-2-git-send-email-carlo@caione.org>
Message-ID: <CAL_JsqLKbfbJJuPe93M8nd4n7eHUQX=9KwGXQ+LOQYVHKKLMXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+dt list

On Wed, Oct 7, 2015 at 3:31 PM, Carlo Caione <carlo@caione.org> wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> Tronfy is an emerging brand in China specializing in Home Theater
> solutions for the normal consumers.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>

Please use scripts/get_maintainers.pl in the future to send to the
right people and lists.

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 82d2ac9..54c91ef 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -222,6 +222,7 @@ toradex     Toradex AG
>  toshiba        Toshiba Corporation
>  toumaz Toumaz
>  tplink TP-LINK Technologies Co., Ltd.
> +tronfy Tronfy
>  truly  Truly Semiconductors Limited
>  usi    Universal Scientific Industrial Co., Ltd.
>  v3     V3 Semiconductor
> --
> 1.9.1
>
