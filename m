From: robherring2@gmail.com (Rob Herring)
Date: Mon, 27 Oct 2014 13:46:04 +0800
Subject: [PATCH v3 1/2] devicetree: bindings: Add vendor prefix for TBS
 Technologies
In-Reply-To: <1414300502-6511-2-git-send-email-smoch@web.de>
References: <1414300502-6511-1-git-send-email-smoch@web.de>
 <1414300502-6511-2-git-send-email-smoch@web.de>
Message-ID: <CAL_Jsq+8EuPz1ceBjY_LWZtrXN1WATG4LcsHksj+U8j334ghHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 26, 2014 at 1:15 PM, Soeren Moch <smoch@web.de> wrote:
> TBS Technologies is a company which specializes in developing, producing
> and marketing of digital TV tuner cards for PCs.
>
> for additional details refer to http://www.tbsdtv.com/about-us.html
>
> Signed-off-by: Soeren Moch <smoch@web.de>

Acked-by: Rob Herring <robh@kernel.org>

> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: devicetree at vger.kernel.org
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index ac7269f..cdc29d4 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -133,6 +133,7 @@ st  STMicroelectronics
>  ste    ST-Ericsson
>  stericsson     ST-Ericsson
>  synology       Synology, Inc.
> +tbs    TBS Technologies
>  ti     Texas Instruments
>  tlm    Trusted Logic Mobility
>  toradex        Toradex AG
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
