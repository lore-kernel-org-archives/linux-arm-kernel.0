From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 11 Dec 2015 00:17:16 -0600
Subject: [PATCH] MAINTAINERS: Add missing platform maintainers for dts
 files
In-Reply-To: <1449790703-12054-1-git-send-email-robh@kernel.org>
References: <1449790703-12054-1-git-send-email-robh@kernel.org>
Message-ID: <20151211061716.GA11957@Agamemnon.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 05:38:23PM -0600, Rob Herring wrote:
> Platform dts files need to be reviewed primarily by the platform
> maintainers as dts files typically go in thru their trees. Add the missing
> paths where there are existing maintainers listed.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

<snip>

>  ARM/Marvell Dove/MV78xx0/Orion SOC support
> @@ -1406,7 +1415,9 @@ M:	David Brown <davidb@codeaurora.org>
>  L:	linux-arm-msm at vger.kernel.org
>  L:	linux-soc at vger.kernel.org
>  S:	Maintained
> +F:	arch/arm/boot/dts/qcom-*
>  F:	arch/arm/mach-qcom/
> +F:	arch/arm64/boot/dts/qcom/*
>  F:	drivers/soc/qcom/
>  F:	drivers/tty/serial/msm_serial.h
>  F:	drivers/tty/serial/msm_serial.c

<snip>

for QCOM,

Acked-by: Andy Gross <agross@codeaurora.org>
