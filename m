From: robherring2@gmail.com (Rob Herring)
Date: Tue, 7 Oct 2014 11:33:46 -0500
Subject: [PATCH v4 2/4] Documentation: devicetree: bindings: Document
 deprecated device vendor name to fix related warning
In-Reply-To: <1412695169-22815-3-git-send-email-darshanapadmadas@gmail.com>
References: <1412695169-22815-1-git-send-email-darshanapadmadas@gmail.com>
 <1412695169-22815-3-git-send-email-darshanapadmadas@gmail.com>
Message-ID: <CAL_JsqKBmwgYF1iQQ_0SzkR9MJZyFj214Je148ONxUh02ZftVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 7, 2014 at 10:19 AM, Darshana Padmadas
<darshanapadmadas@gmail.com> wrote:
> This patch documents deprecated vendor name of device isl29028 for compatibility with older kernels.

Fix your line wrapping to 72 chars.

You can shorten the subject "Documentation: devicetree: bindings:" to
"dt-bindings:". We're horribly inconsistent there...

Rob

> Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index ac7269f..ab97459 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -68,6 +68,7 @@ img   Imagination Technologies Ltd.
>  intel  Intel Corporation
>  intercontrol   Inter Control Group
>  isee   ISEE 2007 S.L.
> +isil    Intersil (deprecated, use isl)
>  isl    Intersil
>  karo   Ka-Ro electronics GmbH
>  keymile        Keymile GmbH
> --
> 1.9.1
>
