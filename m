From: joe@perches.com (Joe Perches)
Date: Wed, 21 Jan 2015 20:46:45 -0800
Subject: [PATCH] MAINTAINERS: update Qualcomm support entry
In-Reply-To: <1421901564-8854-1-git-send-email-agross@codeaurora.org>
References: <1421901564-8854-1-git-send-email-agross@codeaurora.org>
Message-ID: <1421902005.18480.3.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-01-21 at 22:39 -0600, Andy Gross wrote:
> Added myself as a co-maintainer.  Updated the files to include the Qualcomm SoC
> directory.  Added linux-soc mailing list.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -1284,9 +1284,12 @@ S:	Maintained
>  ARM/QUALCOMM SUPPORT
>  M:	Kumar Gala <galak@codeaurora.org>
>  M:	David Brown <davidb@codeaurora.org>
> +M:	Andy Gross <agross@codeaurora.org>
>  L:	linux-arm-msm at vger.kernel.org
> +L:	linux-soc at vger.kernel.org
>  S:	Maintained
>  F:	arch/arm/mach-qcom/
> +F:	drivers/soc/qcom

Please add a terminating /

F:	drivers/soc/qcom/
