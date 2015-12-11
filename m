From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 11 Dec 2015 10:10:14 +0000
Subject: [PATCH] MAINTAINERS: Add missing platform maintainers for dts
 files
In-Reply-To: <1449790703-12054-1-git-send-email-robh@kernel.org>
References: <1449790703-12054-1-git-send-email-robh@kernel.org>
Message-ID: <566AA106.2050404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/12/15 23:38, Rob Herring wrote:
> Platform dts files need to be reviewed primarily by the platform
> maintainers as dts files typically go in thru their trees. Add the missing
> paths where there are existing maintainers listed.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   MAINTAINERS | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 69c8a9c..415b731 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS

[...]

> @@ -1680,7 +1694,7 @@ M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>   L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
>   F:	arch/arm/boot/dts/vexpress*
> -F:	arch/arm64/boot/dts/arm/vexpress*
> +F:	arch/arm64/boot/dts/arm/
>   F:	arch/arm/mach-vexpress/
>   F:	*/*/vexpress*
>   F:	*/*/*/vexpress*

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
