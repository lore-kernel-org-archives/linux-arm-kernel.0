From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 26 Jan 2015 16:51:11 -0800
Subject: [PATCH] MAINTAINERS: update Qualcomm support entry
In-Reply-To: <1421901564-8854-1-git-send-email-agross@codeaurora.org>
References: <1421901564-8854-1-git-send-email-agross@codeaurora.org>
Message-ID: <54C6E0FF.9000103@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/15 20:39, Andy Gross wrote:
> Added myself as a co-maintainer.  Updated the files to include the Qualcomm SoC
> directory.  Added linux-soc mailing list.
>
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> ---
>  MAINTAINERS |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93409ad..2af6e23 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1284,9 +1284,12 @@ S:	Maintained
>  ARM/QUALCOMM SUPPORT
>  M:	Kumar Gala <galak@codeaurora.org>
>  M:	David Brown <davidb@codeaurora.org>
> +M:	Andy Gross <agross@codeaurora.org>
>  L:	linux-arm-msm at vger.kernel.org
> +L:	linux-soc at vger.kernel.org

Should this be here? I'd think we would want this on some more top-level
drivers/soc/ entry so that mach-qcom changes don't go to the linux-soc
list when they're not relevant to linux-soc.

>  S:	Maintained
>  F:	arch/arm/mach-qcom/
> +F:	drivers/soc/qcom
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git
>  
>  ARM/RADISYS ENP2611 MACHINE SUPPORT


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
