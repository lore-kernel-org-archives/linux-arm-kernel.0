From: mporter@linaro.org (Matt Porter)
Date: Tue, 23 Sep 2014 08:48:23 -0400
Subject: [PATCH] MAINTAINERS: add a third maintainer to mach-bcm
In-Reply-To: <1411150632-25695-2-git-send-email-f.fainelli@gmail.com>
References: <1411150632-25695-1-git-send-email-f.fainelli@gmail.com>
 <1411150632-25695-2-git-send-email-f.fainelli@gmail.com>
Message-ID: <20140923124823.GB12283@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 19, 2014 at 11:17:12AM -0700, Florian Fainelli wrote:
> Add myself as a third maintainer to the mach-bcm code to increase the
> chances the redundancy in the merging/reviewing process.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Matt Porter <mporter@linaro.org>

Thanks for offering to take the lead on this. With my change in role at
Linaro and lack of access to Broadcom documentation and tribal knowledge
on Broadcom mobile parts I can't do this justice any longer.

-Matt

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 809ecd680d88..e0762fea2d02 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2004,6 +2004,7 @@ F:	drivers/net/ethernet/broadcom/bnx2x/
>  BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITECTURE
>  M:	Christian Daudt <bcm@fixthebug.org>
>  M:	Matt Porter <mporter@linaro.org>
> +M:	Florian Fainelli <f.fainelli@gmail.com>
>  L:	bcm-kernel-feedback-list at broadcom.com
>  T:	git git://github.com/broadcom/mach-bcm
>  S:	Maintained
> -- 
> 1.9.1
> 
