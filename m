From: robherring2@gmail.com (Rob Herring)
Date: Wed, 28 May 2014 11:18:56 -0500
Subject: [PATCH 1/5] devicetree: bindings: Document micrel vendor prefix
In-Reply-To: <1400792413-21618-2-git-send-email-sboyd@codeaurora.org>
References: <1400792413-21618-1-git-send-email-sboyd@codeaurora.org>
 <1400792413-21618-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <CAL_JsqK1wkXMkJCag5g72enGcss2Cr1fYjEo--KkgQBDGuqyEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 4:00 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> There's one existing use of 'micrel' in the documentation so use
> 'micrel' instead of the company's ticker symbol 'mcrl'.
>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Applied for 3.16.

Rob

> ---
>
> This is mostly here as the first patch to make checkpatch quiet. I expect DT
> maintainers to pick this one up.
>
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 1bc2174e1a05..2fe06ad1d248 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -76,6 +76,7 @@ linux Linux-specific binding
>  lsi    LSI Corp. (LSI Logic)
>  marvell        Marvell Technology Group Ltd.
>  maxim  Maxim Integrated Products
> +micrel Micrel Inc.
>  microchip      Microchip Technology Inc.
>  mosaixtech     Mosaix Technologies, Inc.
>  moxa   Moxa
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
>
