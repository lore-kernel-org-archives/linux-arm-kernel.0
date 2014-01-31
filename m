From: robherring2@gmail.com (Rob Herring)
Date: Fri, 31 Jan 2014 12:20:22 -0600
Subject: [PATCH] of: add vendor prefix for Allwinner Technology
In-Reply-To: <1391045798-7053-1-git-send-email-emilio@elopez.com.ar>
References: <1391045798-7053-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <CAL_Jsq+arxoJ-Ghg-wAB5odcXrBoQ8y_=v=YoExUg8=AojKACw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 7:36 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> We have been using the "allwinner" prefix for everything so far; let's
> document it here.
>
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied.

Rob

>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index edbb8d8..5a2904b 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -7,6 +7,7 @@ ad      Avionic Design GmbH
>  adi    Analog Devices, Inc.
>  aeroflexgaisler        Aeroflex Gaisler AB
>  ak     Asahi Kasei Corp.
> +allwinner      Allwinner Technology Co., Ltd.
>  altr   Altera Corp.
>  amcc   Applied Micro Circuits Corporation (APM, formally AMCC)
>  apm    Applied Micro Circuits Corporation (APM)
> --
> 1.8.5.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
