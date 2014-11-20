From: robherring2@gmail.com (Rob Herring)
Date: Thu, 20 Nov 2014 09:07:27 -0600
Subject: [PATCH 8/9] of: add Fujitsu vendor prefix
In-Reply-To: <1416487165-25551-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1416487165-25551-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <CAL_JsqJdkVvcP95ZZ+dn2z4x7g5k2fs+7bWYUjY2EEo3yVELgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 6:39 AM, Vincent Yang
<vincent.yang.fujitsu@gmail.com> wrote:
> Add 'fujitsu' as the vendor prefix for Fujitsu Semiconductor Ltd.
>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
> Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 723999d..dbb7c97 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -56,6 +56,7 @@ everest       Everest Semiconductor Co. Ltd.
>  excito Excito
>  fcs    Fairchild Semiconductor
>  fsl    Freescale Semiconductor
> +fujitsu Fujitsu Semiconductor Ltd.
>  GEFanuc        GE Fanuc Intelligent Platforms Embedded Systems, Inc.
>  gef    GE Fanuc Intelligent Platforms Embedded Systems, Inc.
>  geniatech      Geniatech, Inc.
> --
> 1.9.0
>
