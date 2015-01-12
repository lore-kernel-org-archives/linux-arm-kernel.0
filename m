From: robherring2@gmail.com (Rob Herring)
Date: Mon, 12 Jan 2015 07:41:25 -0600
Subject: [PATCHv0 1/3] of: add vendor prefix for Abracon Corporation
In-Reply-To: <754e04216222807206344fdd9f8575e6b504ed14.1421045942.git.arno@natisbad.org>
References: <cover.1421045942.git.arno@natisbad.org>
 <754e04216222807206344fdd9f8575e6b504ed14.1421045942.git.arno@natisbad.org>
Message-ID: <CAL_JsqL=yP1XmhNiV6Rq_t=ktE1FDBmRKYNNJ0Tn3iAkM3ecag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 2:16 AM, Arnaud Ebalard <arno@natisbad.org> wrote:
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index b1df0ad1306c..44defc3c162a 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -4,6 +4,7 @@ This isn't an exhaustive list, but you should add new prefixes to it before
>  using them to avoid name-space collisions.
>
>  abilis Abilis Systems
> +abcn   Abracon Corporation

Is there some reason not to use "abracon"?

>  active-semi    Active-Semi International Inc
>  ad     Avionic Design GmbH
>  adapteva       Adapteva, Inc.
> --
> 2.1.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
